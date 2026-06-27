path = r'd:\hackathon\lib\main.dart'
with open(path, 'r', encoding='utf-8') as f:
    content = f.read()

# Find position of second 'void main()'
first = content.find('void main()')
second = content.find('void main()', first + 1)

if second > 0:
    # Keep everything before the blank lines preceding second void main()
    # Find the last '}' before second void main
    end_pos = content.rfind('}', 0, second)
    clean = content[:end_pos + 1] + '\n'
    with open(path, 'w', encoding='utf-8') as f:
        f.write(clean)
    
    with open(path, 'r', encoding='utf-8') as f:
        new_content = f.read()
    
    # Write verification to a log file
    with open(r'd:\hackathon\log.txt', 'w') as log:
        log.write(f'Original length: {len(content)}\n')
        log.write(f'New length: {len(new_content)}\n')
        log.write(f'Has second main: {\"void main()\" in new_content.split(chr(10),1)[1] if len(new_content.split(chr(10))) > 1 else \"N/A\"}\n')
        log.write(f'Content:\\n{new_content}\\n')
