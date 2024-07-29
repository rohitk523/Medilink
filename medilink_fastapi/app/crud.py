from sqlalchemy.orm import Session
from . import models, schemas
from passlib.context import CryptContext
import uuid

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


def create_patient(db: Session, patient: schemas.Patient):
    id = str(uuid.uuid4())
    db_patient = models.Patient(id= id, name=patient.name, contact=patient.contact, age=patient.age, city=patient.city)
    db.add(db_patient)
    db.commit()
    db.refresh(db_patient)
    return db_patient


def get_doctors(db: Session):
    return db.query(models.Doctor).all()
