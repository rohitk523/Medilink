import pytest
from fastapi.testclient import TestClient
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker
from sqlalchemy.pool import StaticPool

from app.database import Base
from app.main import app
from app.database import get_db

# Create an in-memory SQLite database for testing
SQLALCHEMY_DATABASE_URL = "sqlite:///:memory:"

engine = create_engine(
    SQLALCHEMY_DATABASE_URL,
    connect_args={"check_same_thread": False},
    poolclass=StaticPool,
)
TestingSessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

@pytest.fixture(scope="function")
def db():
    Base.metadata.create_all(bind=engine)
    db = TestingSessionLocal()
    try:
        yield db
    finally:
        db.close()
        Base.metadata.drop_all(bind=engine)

@pytest.fixture(scope="function")
def client(db):
    def override_get_db():
        try:
            yield db
        finally:
            db.close()
    
    app.dependency_overrides[get_db] = override_get_db
    with TestClient(app) as test_client:
        yield test_client
    app.dependency_overrides.clear()

@pytest.fixture
def test_patient():
    return {
        "username": "testuser",
        "password": "testpassword",
        "email": "test@example.com",
        "full_name": "Test User"
    }

@pytest.fixture
def auth_headers(client, test_patient):
    # Create a test user
    client.post("/signup_patient/", json=test_patient)
    
    # Get token
    response = client.post(
        "/token",
        data={
            "username": test_patient["username"],
            "password": test_patient["password"]
        }
    )
    token = response.json()["access_token"]
    return {"Authorization": f"Bearer {token}"}