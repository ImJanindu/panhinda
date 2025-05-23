from hashlib import sha256


def get_sha256_hash(data: str):
    hashed_method = sha256()
    hashed_method.update(data.encode())
    return hashed_method.hexdigest()
