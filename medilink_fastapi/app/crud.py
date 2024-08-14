from sqlalchemy.orm import Session
from fastapi import HTTPException
from . import models, schemas
from passlib.context import CryptContext
import uuid
import bcrypt
from .schemas import PatientData
from .models import Patient


pwd_context = CryptContext(schemes=["bcrypt"], deprecated="auto")

def get_password_hash(password):
    return pwd_context.hash(password)

def create_doctor(db: Session, doctor: schemas.Doctor):
    hashed_password = get_password_hash(doctor.password)
    db_doctor = models.Doctor(username=doctor.username, password=hashed_password)
    db.add(db_doctor)
    db.commit()
    db.refresh(db_doctor)
    return db_doctor

def get_doctor_by_username(db: Session, username: str):
    return db.query(models.Doctor).filter(models.Doctor.username == username).first()

def verify_password(plain_password, hashed_password):
    return pwd_context.verify(plain_password, hashed_password)


def create_patient(db: Session, patient: PatientData):
    if patient.password != patient.confirm_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")
    
    hashed_password = bcrypt.hashpw(patient.password.encode('utf-8'), bcrypt.gensalt()).decode('utf-8')
    
    db_patient = Patient(
        username=patient.username,
        password=hashed_password
    )
    
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    
    return db_patient

def add_patient_data(username: str, patient: PatientData, db: Session):
    db_patient = db.query(Patient).filter(Patient.username == username).first()
    
    if not db_patient:
        raise HTTPException(status_code=404, detail="Patient not found")

    # Update fields only if they are provided (i.e., not None)
    if patient.dob is not None:
        db_patient.dob = patient.dob
    if patient.height is not None:
        db_patient.height = patient.height
    if patient.weight is not None:
        db_patient.weight = patient.weight
    
    db.commit()
    db.refresh(db_patient)
    
    return db_patient


def get_doctors(db: Session):
    return db.query(models.Doctor).all()
