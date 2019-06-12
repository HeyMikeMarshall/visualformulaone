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
        details.append([result[0], f"{result[1]}", f"{result[2]}", result[3], result[4], result[5]])
    return details


def getracesummary(race_id):
    import sqlalchemy
    from sqlalchemy.ext.automap import automap_base
    from sqlalchemy.orm import Session
    from sqlalchemy import create_engine, func, inspect

    engine = create_engine(f'postgresql://f1db_public:t4T%K2@8s2XbG@localhost:5432/f1db')
    Base = automap_base()
    Base.prepare(engine, reflect=True)
    
    Results = Base.classes.results
    Status = Base.classes.status
    Constructors = Base.classes.constructors
    Drivers = Base.classes.drivers
    session = Session(engine)
    
    racesummary = session.query(Results.number, Drivers.forename, Drivers.surname, Drivers.nationality, Constructors.name,\
                               Results.position, Results.time, Results.laps, Status.status).\
            join(Drivers, Drivers.driver_id == Results.driver_id).\
            join(Status, Status.status_id == Results.status_id).\
            join(Constructors, Constructors.constructor_id == Results.constructor_id).\
            filter(Results.race_id == race_id).order_by(Results.position.asc()).all()
    
    summary = []
    for result in racesummary:
        summary.append({'number': result[0],
            'name': f"{result[1]} {result[2]}",
            'nationality': result[3],
            'constructor': result[4],
            'position': result[5],
            'time': result[6],
            'laps': result[7],
            'status': result[8]}
        )
    
    
    return summary


def getracedetails(race_id):
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
    
    result = session.query(Races.year, Races.round, Circuits.name, Races.name, Circuits.country, Races.date, Races.race_id).\
            join(Circuits, Circuits.circuit_id == Races.circuit_id).filter(Races.race_id == race_id).all()
    
    details = {'year': result[0][0],
            'round': result[0][1],
            'circuit': f"{result[0][2]}",
            'race': f"{result[0][3]}",
            'country': result[0][4],
            'date': result[0][5]}
        
    return details