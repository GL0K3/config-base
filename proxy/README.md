# Usage

Add secret.yml with this values

```yaml
proxy_server: IP
proxy_server_port: PORT
proxy_password: PASS
```

```bash
ansible-playbook -e ansible_user=$(whoami) --ask-vault-pass setup.yml
```
