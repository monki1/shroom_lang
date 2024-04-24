// Example IO for the DSL parser
// DSL Parser Tests
Map<String, dynamic> EXAMPLES = {
  // Create operations
  "+  id123 profile : {address  :  {city:NewYork state:NY } friends:[@123] }": {
                'operation': 'create',
                'path': ['id123'],
                'attributes': {
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
                        'value': [{'type': 'node_ref', 'value': {'type': 'id', 'value': 123}}]
                      }
                    }
                  }
                }
              },

  // // Read operation
  // "@id123:profile": [
  //   {
  //     "operation": "read",
  //     "identification": "id123",
  //     "key": "profile"
  //   }
  // ],

  // // Update operation
  // "^id123 profile:{name:Jane} friends:[@idstr @123]": [
  //   {
  //     "operation": "update",
  //     "identification": "id123",
  //     "attributes": {
  //       "profile": {"name": "Jane"},
  //       "friends": ["idstr", 123]
  //     }
  //   }
  // ],

  // // Delete operation
  // "-id123": [
  //   {
  //     "operation": "delete",
  //     "identification": "id123"
  //   }
  // ]
};
