from fastapi import APIRouter, Depends, HTTPException, status
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..models import Visit, Patient
from ..schemas import BPData
from ..auth import get_current_user

router = APIRouter(
    tags=["dashboard"],
)

@router.get("/bp_data", response_model=List[BPData])
def get_bp_data(db: Session = Depends(get_db)):
    bp_data = db.query(Visit.BP).all()
    return [{"bp": bp} for bp, in bp_data]


@router.get("/bp_data", response_model=List[BPData])
def get_bp_data(
    db: Session = Depends(get_db),
    current_user: Patient = Depends(get_current_user)
):
    bp_data = db.query(Visit.BP).filter(Visit.patient_id == current_user.id).all()

    if not bp_data:
        raise HTTPException(status_code=status.HTTP_404_NOT_FOUND, detail="No BP data found for the current user")

    return [{"bp": bp} for bp, in bp_data]
