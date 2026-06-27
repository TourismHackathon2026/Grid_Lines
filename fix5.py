content = ''
with open(r'd:\hackathon\lib\main.dart', 'r') as f:
    content = f.read()
lines = content.split('\n')
first_30 = lines[:30]
result = '\n'.join(first_30)
with open(r'd:\hackathon\lib\main.dart', 'w') as f:
    f.write(result)
print('Done')
