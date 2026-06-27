path = r'd:\hackathon\lib\main.dart'
with open(path, 'r', encoding='utf-8') as f:
    lines = f.readlines()

clean_lines = []
for line in lines[:29]:
    line = line.rstrip('\n\r')
    clean_lines.append(line)

with open(path, 'w', encoding='utf-8') as f:
    f.write('\n'.join(clean_lines) + '\n')

print(f'Written {len(clean_lines)} lines')

