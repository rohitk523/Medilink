from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from typing import List
from ..database import get_db
from ..models import Visit
from ..schemas import BPData

router = APIRouter(
    tags=["dashboard"],
)

@router.get("/bp_data", response_model=List[BPData])
def get_bp_data(db: Session = Depends(get_db)):
    bp_data = db.query(Visit.BP).all()
    return [{"bp": bp} for bp, in bp_data]
