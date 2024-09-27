#!/usr/bin/env python3
'''Task 12's module.
'''
from pymongo import MongoClient


def print_nginx_request_logs(nginx_collection):
    '''Prints stats about Nginx request logs.'''
    total_logs = nginx_collection.count_documents({})
    if total_logs == 0:
        print('0 logs')
        print('Methods:')
        print('\tmethod GET: 0')
        print('\tmethod POST: 0')
        print('\tmethod PUT: 0')
        print('\tmethod PATCH: 0')
        print('\tmethod DELETE: 0')
        print('0 status check')
        return

    # print('{} logs'.format(total_logs))
    # Handle singular/plural
    print('{} log{}'.format(
        total_logs,
        '' if total_logs == 1 else 's'))

    print('Methods:')
    methods = ['GET', 'POST', 'PUT', 'PATCH', 'DELETE']
    for method in methods:
        req_count = nginx_collection.find({'method': method})
        print('\tmethod {}: {}'.format(method, req_count))

    status_checks_count = nginx_collection.count_documents(
        {'method': 'GET',
         'path': '/status'})
    # print('{} status check'.format(status_checks_count))
    # Handle singular/plural
    print('{} status check{}'.format(
        status_checks_count,
        '' if status_checks_count == 1 else 's'))


def run():
    '''Provides some stats about Nginx logs stored in MongoDB.'''
    client = MongoClient('mongodb://127.0.0.1:27017')
    # Access the correct database and collection
    print_nginx_request_logs(client.logs.nginx)


if __name__ == '__main__':
    run()
