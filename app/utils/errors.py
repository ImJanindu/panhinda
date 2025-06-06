class ContentNotFoundError(Exception):
    def __init__(self, message: str='Sorry! Page Doesn\'t Exists', previous_url: str='index'):
        super().__init__()
        self.status_code = 404
        self.message = message
        self.previous_url = previous_url


class InternalServerError(Exception):
    def __init__(self, message: str='Sorry! Problem Occurred at Our End', previous_url: str='index'):
        super().__init__()
        self.status_code = 500
        self.message = message
        self.previous_url = previous_url

class NotAuthorizedError(Exception):
    def __init__(self, message: str='Hmm. You\'re not Authorized', previous_url: str='index'):
        super().__init__()
        self.status_code = 401
        self.message = message
        self.previous_url = previous_url

class NotAllowedError(Exception):
    def __init__(self, message: str='Sorry! Cannot Allowed to Proceed', previous_url: str='index'):
        super().__init__()
        self.status_code = 500
        self.message = message
        self.previous_url = previous_url

