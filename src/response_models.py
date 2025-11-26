from pydantic import BaseModel

from data_types import Doc_Info

class List_Res(BaseModel):
    ids: list[str]

class Get_Res(BaseModel):
    docs: list[Doc_Info]

class Upload_Res(BaseModel):
    ids: list[str]

class Delete_Res(BaseModel):
    ids: list[str]

