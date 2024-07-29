from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from fastapi import APIRouter
from .. import schemas, crud
from ..auth import get_current_user
from ..models import Patient


router = APIRouter(tags=["Patient"],)


# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()

@router.post("/signup_patient/", response_model=schemas.Patient)
def create_patient(patient: schemas.Patient, db: Session = Depends(get_db), current_user: Patient = Depends(get_current_user)):
    # db_user = crud.get_user_by_email(db, email=user.email)
    # if db_user:
    #     raise HTTPException(status_code=400, detail="Email already registered")
    print(current_user)
    return crud.create_patient(db=db, patient=patient)
