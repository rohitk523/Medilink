from sqlalchemy.orm import Session

from . import models, schemas


def create_doctor(db: Session, doctor: schemas.Doctor):
    db_doctor = models.Doctor(username=doctor.username, password=doctor.password)
    db.add(db_doctor)
    db.commit()
    db.refresh(db_doctor)
    return db_doctor


def create_patient(db: Session, patient: schemas.Patient):
    db_patient = models.Patient(name=patient.name, contact=patient.contact, age=patient.age, city=patient.city)
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    return db_patient


def get_doctors(db: Session):
    return db.query(models.Doctor).all()
