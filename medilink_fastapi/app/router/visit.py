from typing import List
from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from .. import crud, models, schemas
from ..database import get_db

router = APIRouter(tags=["Visit"])

@router.post("/visits/", response_model=schemas.Visit)
def create_visit(visit: schemas.VisitCreate, db: Session = Depends(get_db)):
    return crud.create_visit(db=db, visit=visit)

@router.get("/visits/", response_model=List[schemas.Visit])
def read_visits(skip: int = 0, limit: int = 10, db: Session = Depends(get_db)):
    visits = crud.get_visits(db, skip=skip, limit=limit)
    return visits

@router.get("/visits/{visit_id}", response_model=schemas.Visit)
def read_visit(visit_id: str, db: Session = Depends(get_db)):
    db_visit = crud.get_visit(db=db, visit_id=visit_id)
    if db_visit is None:
        raise HTTPException(status_code=404, detail="Visit not found")
    return db_visit