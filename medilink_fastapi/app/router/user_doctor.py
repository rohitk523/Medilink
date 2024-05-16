from fastapi import HTTPException, Depends
from sqlalchemy.orm import Session
from ..database import SessionLocal
from fastapi import APIRouter
from .. import schemas, crud

router = APIRouter(tags=["Doctor"],)

# Dependency
def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()


@router.post("/signup_doc/", response_model=schemas.Doctor)
def create_doctor(doctor: schemas.Doctor, db: Session = Depends(get_db)):
    # db_user = crud.get_user_by_email(db, email=user.email)
    # if db_user:
    #     raise HTTPException(status_code=400, detail="Email already registered")
    return crud.create_doctor(db=db, doctor=doctor)


@router.get('/get_doctors')
def get_doctors(db: Session = Depends(get_db)):
    return crud.get_doctors(db=db)