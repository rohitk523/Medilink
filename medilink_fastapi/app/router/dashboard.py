from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from .database import get_db
from .models import Visit
from .schemas import BPData

router = APIRouter(
    prefix="/dashboard",
    tags=["dashboard"],
)

@router.get("/bp_data", response_model=List[BPData])
def get_bp_data(db: Session = Depends(get_db)):
    bp_data = db.query(Visit.BP, Visit.date).all()  # Assuming there is a `date` field in the Visit table
    return [{"bp": bp, "date": date} for bp, date in bp_data]
