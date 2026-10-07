"""Local consistency checks; does not require Azure credentials."""
from pathlib import Path
import re
import subprocess

root = Path(__file__).resolve().parents[1]
pipeline = (root / 'Jenkinsfile').read_text()
outputs = (root / 'terraform/outputs.tf').read_text()
for name in re.findall(r'output -raw (\w+)', pipeline):
    assert f'output "{name}"' in outputs, f'Missing Terraform output: {name}'
assert 'ansible/install_web.yml' in (root / 'scripts/deploy.sh').read_text()
assert 'Azure DevOps Automated Deployment' in (root / 'app/index.html').read_text()
tracked = subprocess.check_output(['git', 'ls-files'], cwd=root, text=True).splitlines()
for name in tracked:
    if not (root / name).exists():
        continue
    assert not re.search(r'\.tfstate(?:\.|$)|\.(pem|key)$|(?:^|/)\.env$', name), f'Sensitive tracked file: {name}'
for path in (root / 'terraform').glob('*.tf'):
    assert 'C:/' not in path.read_text(), f'Local path in {path.name}'
print('Output references, deployment artifact, portable paths and current-tree hygiene passed.')
