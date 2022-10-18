# openknowit_SE-linux_traclker
command: vault kv put "dnsinabox/services/traeckle.com/local.{{ ansible_hostname }}" type="A" ipv4="{{  ansible_default_ipv4.address }}"
