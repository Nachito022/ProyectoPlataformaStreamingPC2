import datetime

#Script auxiliar para cosas diversas

def get_current_time():
    return datetime.datetime.now()

def get_30_days_ago():
    return get_current_time().date() - datetime.timedelta(days = 30)
