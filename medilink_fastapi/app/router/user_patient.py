from typing import Annotated
from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from fastapi import APIRouter
from .. import schemas, crud
from ..schemas import PatientData, PatientLogin, PatientCreate
from ..auth import User, get_current_user, login_patient

router = APIRouter(tags=["Patient"],)


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


# , current_user: Patient = Depends(get_current_user)

@router.post("/signup_patient/", response_model=PatientCreate)
def create_patient_route(patient: PatientCreate, db: Session = Depends(get_db)):
    # You might want to check if the username already exists
    db_patient = crud.create_patient(db=db, patient=patient)
    return db_patient


@router.post("/add_patient_data/{username}", response_model=PatientData)
def add_patient_data_route(username: str, patient: PatientData, db: Session = Depends(get_db)):
    db_patient = crud.add_patient_data(username=username, db=db, patient=patient)
    return db_patient



@router.post("/login_patient/", response_model=PatientLogin)
def login_patient_route(patient_login: PatientLogin, db: Session = Depends(get_db), current_user: User  = Depends(get_current_user)):
    return login_patient(db, patient_login)
