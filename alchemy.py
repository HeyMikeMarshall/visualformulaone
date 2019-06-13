def getseasonlist():
    import sqlalchemy
    from sqlalchemy.ext.automap import automap_base
    from sqlalchemy.orm import Session
    from sqlalchemy import create_engine, func, inspect

    engine = create_engine(f'postgresql://f1db_public:t4T%K2@8s2XbG@localhost:5432/f1db')
    Base = automap_base()
    Base.prepare(engine, reflect=True)
    Seasons = Base.classes.seasons
    session = Session(engine)
    return session.query(Seasons.year).order_by(Seasons.year.desc()).all()

def getseasondetails(year):
    import sqlalchemy
    from sqlalchemy.ext.automap import automap_base
    from sqlalchemy.orm import Session
    from sqlalchemy import create_engine, func, inspect

    engine = create_engine(f'postgresql://f1db_public:t4T%K2@8s2XbG@localhost:5432/f1db')
    Base = automap_base()
    Base.prepare(engine, reflect=True)
    
    Races = Base.classes.races
    Circuits = Base.classes.circuits
    session = Session(engine)
    
    query = session.query(Races.round, Circuits.name, Races.name, Circuits.country, Races.date, Races.race_id).\
            join(Circuits, Circuits.circuit_id == Races.circuit_id).filter(Races.year == year).all()

    details = []
    for result in query:
        details.append({'round': result[0],
        'circuit': f"{result[1]}",
        'race': result[2],
        'country': result[3],
        'date': result[4],
        'race_id': result[5]})

    return details

def getracedetails(race_id):
    import sqlalchemy
    from sqlalchemy.ext.automap import automap_base
    from sqlalchemy.orm import Session
    from sqlalchemy import create_engine, func, inspect, and_

    engine = create_engine(f'postgresql://f1db_public:t4T%K2@8s2XbG@localhost:5432/f1db')
    Base = automap_base()
    Base.prepare(engine, reflect=True)
    
    
    Circuits = Base.classes.circuits
    Races = Base.classes.races
    Results = Base.classes.results
    Status = Base.classes.status
    Constructors = Base.classes.constructors
    Drivers = Base.classes.drivers
    DriverStandings = Base.classes.driver_standings
    ConstructorResults = Base.classes.constructor_results
    ConstructorStandings = Base.classes.constructor_standings

    session = Session(engine)
    
    results_q = session.query(Results.number, Drivers.forename, Drivers.surname, Drivers.nationality, Constructors.name,\
                               Results.grid, Results.position, Results.time, Results.laps, Status.status, Results.points).\
                                join(Drivers, Drivers.driver_id == Results.driver_id).\
                                join(Status, Status.status_id == Results.status_id).\
                                join(Constructors, Constructors.constructor_id == Results.constructor_id).\
                                filter(Results.race_id == race_id).order_by(Results.position.asc()).all()
    
    results = []
    for result in results_q:
        rtime = result[7]
        if rtime == None:
            rtime = result[9]
            if rtime[0] != '+':
                rtime = f"DNF - {result[9]}"
        
        
        results.append({'number': result[0],
            'name': f"{result[1]} {result[2]}",
            'nationality': result[3],
            'constructor': result[4],
            'grid position':result[5],
            'position': result[6],
            'time': rtime,
            'points': result[10]}
        )
    
    dstandings_q = session.query(Results.number, Drivers.forename, Drivers.surname,\
                               Results.points, DriverStandings.points, DriverStandings.position, DriverStandings.wins).\
                                join(Drivers, Drivers.driver_id == Results.driver_id).\
                                outerjoin(DriverStandings, and_(DriverStandings.driver_id == Drivers.driver_id, DriverStandings.race_id == race_id)).\
                                filter(Results.race_id == race_id).order_by(DriverStandings.position.asc()).all()
    
    dstandings = []
    for result in dstandings_q:
        dstandings.append({'number': result[0],
            'name': f"{result[1]} {result[2]}",
            'race_points': result[3],
            'champ_points': result[4],
            'position': result[5],
            'season_wins':result[6]})
    
    
    
    cstandings_q = session.query(Constructors.name, ConstructorResults.points, ConstructorStandings.points,\
                               ConstructorStandings.position, ConstructorStandings.wins).\
                                join(ConstructorResults, ConstructorResults.constructor_id == Constructors.constructor_id).\
                                outerjoin(ConstructorStandings, and_(ConstructorStandings.race_id == ConstructorResults.race_id,\
                                                                     ConstructorStandings.constructor_id == Constructors.constructor_id)).\
                                filter(ConstructorResults.race_id == race_id).order_by(ConstructorStandings.position.asc()).all()
    
    cstandings = []
    for result in cstandings_q:
        cstandings.append({'constructor': f"{result[0]}",
            'race_points': result[1],
            'champ_points': result[2],
            'position': result[3],
            'season_wins': result[4]})
    
    
    
    details_q = session.query(Races.year, Races.round, Circuits.name, Races.name, Circuits.country, Races.date, Races.race_id).\
            join(Circuits, Circuits.circuit_id == Races.circuit_id).filter(Races.race_id == race_id).all()
    
    details = {'year': details_q[0][0],
            'round': details_q[0][1],
            'circuit': f"{details_q[0][2]}",
            'race': f"{details_q[0][3]}",
            'country': details_q[0][4],
            'date': details_q[0][5]}
    
    
    
    summary = {'details':details,
                'results':results,
                'dstandings':dstandings,
              'cstandings':cstandings}
    
    
    
    
    
    return summary

