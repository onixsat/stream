<h1 align="center">Bash Almalinux 8</h1>
<h6 align="center">💻 Linguagens de Programação</h6>
<a id="readme-top"></a>
<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/onixsat">
    <img src="scripts/logo.png" alt="Logo" width="80" height="80">
  </a>
</div>

<!-- TABLE OF CONTENTS -->
<details>
  <summary>Table of Contents</summary>
  <ol>
    <li>
      <a href="#Códigos">Códigos</a>
      <ul>
        <li><a href="#Servidor">Servidor</a></li>
      </ul>
    </li>
    <li>
      <a href="#getting-started">Getting Started</a>
      <ul>
        <li><a href="#prerequisites">Prerequisites</a></li>
        <li><a href="#installation">Installation</a></li>
      </ul>
    </li>
    <li><a href="#usage">Usage</a></li>
    <li><a href="#roadmap">Roadmap</a></li>
    <li><a href="#contributing">Contributing</a></li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
    <li><a href="#acknowledgments">Acknowledgments</a></li>
  </ol>
</details>

## 🛠️ Códigos
* Códigos gerais para shell

### Servidor
* Proteger alteração de ficheiros
```bash
chattr -i /etc/mailips
chattr -i /etc/mailhelo

chattr +i /etc/mailips
chattr +i /etc/mailhelo
```

* Outros

```bash
banner "Apache" "Configuracão" "Password"
titulo "Atualizando o sistema..."

declare -A myArray
  myArray[A]="yum update -y"
  myArray[B]="hostname>h.txt"
  
dados=$(jstrings ' && ' "${myArray[@]}")
esperar "$dados" "${WHITE}Atualizando..." "Atualizado!"
```

* Carregar
```bash
function carregar(){
  start_time2=$(date +%s%3N)
  start_loading "Carregando..."
  sleep 5
  stop_loading $?
  end_time2=$(date +%s%3N)
  duration_ms2=$((end_time2 - start_time2))
  echo "Execution: $duration_ms2"
}

esperar carregar "${WHITE}Carregando..." "Carregado!"
```

* Outros
  Contato
<p align="right">(<a href="#readme-top">back to top</a>)</p>

