
<p align="center" class="text-center" style="text-align:center;"><a href="https://github.com/marcelosenabr" target="_blank"><img src="assets/logo.png" width="200"></a></p>

## Modelo de pacote/script

Template para pacote/script bash

## Estrutura

```
.
├── assets
│   └── logo.png
├── bashtemplate
├── bashtemplate.sh
├── bin
├── cores.bash
├── dependencias
├── dependencias.sh
├── env.bash
├── LICENSE.md
├── README.md
├── script.bash
└── VERSION.md
```

## Instalação

1. git clone https://github.com/marcelosenabr/bashtemplate.git novoscript && cd novoscript
2. Altere o nome dos arquivos `bashtemplate` e `bashtemplate.sh` com o nome do novo script
3. Executa na raiz do script `source novoscript`
4. novoscript -v

## Exemplo

```bash
git clone https://github.com/marcelosenabr/bashtemplate.git novoscript && cd novoscript
mv bashtemplate novoscript
mv bashtemplate.sh novoscript.sh
source novoscript
source ~/.bashrc
novoscript -v
```

## Licença

Licença MIT (MIT). Consulte o [Arquivo de Licença](LICENSE.md) para obter mais informações.
