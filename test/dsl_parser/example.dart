// Example IO for the DSL parser
// DSL Parser Tests
Map<String, dynamic> EXAMPLES = {
  // Create operations
  "+ id123 active:true profile : {address  :  {city:NewYork state:NY } friends:[@123] }": {
    'operation': 'create',
    'path': ['id123'],
    'attributes': {
      'active': {'type': 'bool', 'value': true},
      'profile': {
        'type': 'node',
        'value': {
          'address': {
            'type': 'node',
            'value': {
              'city': {'type': 'string', 'value': 'NewYork'},
              'state': {'type': 'string', 'value': 'NY'}
            }
          },
          'friends': {
            'type': 'list',
            'value': [
              {
                'type': 'node_ref',
                'value': {'type': 'id', 'value': 123}
              }
            ]
          }
        }
      }
    }
  },
  "+ user1 name:John age:25 status:active friends:[@idstr @123 @sajo] year:2021": {
    'operation': 'create',
    'path': ['user1'],
    'attributes': {
      'name': {'type': 'string', 'value': 'John'},
      'age': {'type': 'int', 'value': 25},
      'status': {'type': 'string', 'value': 'active'},
      'friends': {
        'type': 'list',
        'value': [
          {'type': 'node_ref', 'value': {'type': 'path', 'value': ['idstr']}},
          {'type': 'node_ref', 'value': {'type': 'id', 'value': 123}},
          {'type': 'node_ref', 'value': {'type': 'path', 'value': ['sajo']}}
        ]
      },
      'year': {'type': 'int', 'value': 2021}
    }
  },

  // Read operation
  "@id123:profile :address": 
    {
                'operation': 'read',
                'identification': {'type': 'path', 'value': ['id123']},
                'keys': ['profile', 'address']
              }
  ,
  "@user1:friends": 
              {
                'operation': 'read',
                'identification': {'type': 'path', 'value': ['user1']},
                'keys': ['friends']
              }
            ,

  // Update operation
  "^id123 profile:{name:Jane} friends:[@idstr @123]": {
                'operation': 'update',
                'identification': {'type': 'path', 'value': ['id123']},
                'attributes': {
                  'profile': {'type': 'node', 'value': {'name': {'type': 'string', 'value': 'Jane'}}},
                  'friends': {
                    'type': 'list',
                    'value': [
                      {'type': 'node_ref', 'value': {'type': 'path', 'value': ['idstr']}},
                      {'type': 'node_ref', 'value': {'type': 'id', 'value': 123}}
                    ]
                  }
                }
              },
  "^user1 address:{city:\"San Francisco\"} friends:[@user5]": {
                'operation': 'update',
                'identification': {'type': 'path', 'value': ['user1']},
                'attributes': {
                  'address': {
                    'type': 'node',
                    'value': {'city': {'type': 'string', 'value': 'San Francisco'}}
                  },
                  'friends': {
                    'type': 'list',
                    'value': [{'type': 'node_ref', 'value': {'type': 'path', 'value': ['user5']}}]
                  }
                }
              },

  // // Delete operation
  "-id123": {
                'operation': 'delete',
                'identification': {'type': 'path', 'value': ['id123']},
                'keys': []
              },
  "-user1:friends :famlies": {
                'operation': 'delete',
                'identification': {'type': 'path', 'value': ['user1']},
                'keys': ['friends', 'famlies']
              }
};
