# linux-rpi

Organização e configuração dos Raspberry Pis das TVs de monitoramento da Blue3.

## Estrutura (planejada)

- `docs/` — inventário, rede, procedimentos
- `scripts/` — provisionamento e manutenção
- `config/` — arquivos de configuração por dispositivo

> Não commitar senhas, tokens ou chaves. Use `.env` local (ignorado pelo git).

## Kiosk (TVs de monitoramento)

`kiosk/` — Raspberry Pi OS Lite (Debian 13) + `cage` + Chromium em tela cheia, alternando entre as URLs de `kiosk/urls.txt` a cada 120 s (via DevTools, porta local 9222).

Instalar num Pi novo: `apt install cage chromium curl`, copiar `urls.txt` para `/etc/kiosk/`, os `.sh` para `/usr/local/bin/`, os `.service` para `/etc/systemd/system/`, e `systemctl enable kiosk kiosk-rotate`.
