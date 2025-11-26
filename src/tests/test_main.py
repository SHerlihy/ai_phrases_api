import pytest
import requests
import pathlib

from pydantic import ValidationError

import response_models as res_m

SCRIPT_PATH = pathlib.Path(__file__).parent.resolve()

base_url = "https://api.nasa.gov/neo/rest/v1/feed/"

auth_key = "authorised"
deny_key = "unauthorised"

deny_base_url = f'{base_url}?api_key={deny_key}'
auth_base_url = f'{base_url}?api_key={auth_key}'

def test_authorised():
    response = requests.get(auth_base_url)
    assert response.status_code == 200

def test_unauthorised():
    response = requests.get(deny_base_url)
    assert response.status_code == 403

@pytest.fixture(scope="class")
def seed_store():
    ##seed
    yield
    ##unseed

class Test_Response_Shape():
    def test_list_all(self, seed_store): 
        response = requests.get(auth_base_url)
    
        assert response.status_code == 200
        assert response.headers["Content-Type"] == "application/json; charset=UTF-8"
    
        data = response.json()
    
        assert isinstance(data, dict)
    
        with pytest.raises(ValidationError) as e:
            res_m.List_Res(**data)
    
    def test_delete_by_id_returns_id(self, seed_store):
        del_ids = []
        req_url = f'{auth_base_url},doc_ids={"".join(del_ids)}'
        response = requests.delete(req_url)
    
        assert response.status_code == 204
        assert response.headers["Content-Type"] == "application/json; charset=UTF-8"
    
        data = response.json()
    
        assert isinstance(data, dict)
    
        with pytest.raises(ValidationError) as e:
            res_m.Delete_Res(**data)
    
    def test_create_returns_doc_data(self, seed_store):
        #why rb ??
        files = {'file': open(f'{SCRIPT_PATH}/example_docs/empty.txt', 'rb')}
        response = requests.post(auth_base_url, files=files)
    
        assert response.status_code == 201
        assert response.headers["Content-Type"] == "application/json; charset=UTF-8"
    
        data = response.json()
    
        assert isinstance(data, dict)
    
        with pytest.raises(ValidationError) as e:
            res_m.Upload_Res(**data)
