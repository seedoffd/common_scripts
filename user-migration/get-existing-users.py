import json
from app import User

output_users = []
data = User.query.all()

for user in data:
    output_users.append(
      {
        "firstname" : user.firstname,
        "lastname"  : user.lastname,
        "username"  : user.username,
        "password"  : user.password,
        "email"     : user.email,
        "role"      : user.role
      })


print(json.dumps(output_users, indent=2))
with open('users.json', 'w') as file:
    json.dump(output_users, file, indent=2)
