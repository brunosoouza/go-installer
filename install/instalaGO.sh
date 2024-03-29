#!/bin/bash

confirguarNovoGo(){
    echo "escolha o diretorio para instalação"
    echo "1. /opt"
    echo "2. /usr/local"
    read -p " padrao: /opt > " opcao
    
    case $opcao in
    1) sudo tar -C /opt -xzf `ls|grep go*.tar.gz | tail -1`
        echo export PATH="$"PATH:/opt/go/bin >> $HOME/.bashrc
        echo export GOPATH=$HOME/go >> $HOME/.bashrc
        echo export PATH=$(go env GOPATH)/bin:$PATH >> $HOME/.bashrc
    ;;

    2) sudo tar -C /usr/local -xzf `ls|grep go*.tar.gz | tail -1`
        echo export PATH="$"PATH:/usr/local/go/bin >> $HOME/.bashrc
        echo export GOPATH=$HOME/go >> $HOME/.bashrc
        echo export PATH=$(go env GOPATH)/bin:$PATH >> $HOME/.bashrc
    ;;

    *) sudo tar -C /opt -xzf `ls|grep go*.tar.gz | tail -1`
        echo export PATH="$"PATH:/opt/go/bin >> $HOME/.bashrc
        echo export GOPATH=$HOME/go >> $HOME/.bashrc
        echo export PATH=$(go env GOPATH)/bin:$PATH >> $HOME/.bashrc
        ;;
    esac
}

configurarGoEncontrado(){
    echo "escolha o diretorio para instalação"
    echo "1. /opt"
    echo "2. /usr/local"
    read -p " padrao: /opt > " opcao
    
    case $opcao in
    1)  sudo tar -C /opt -xzf `ls|grep go*tar.gz | tail -1`
        echo export PATH="$"PATH:/opt/go/bin >> $HOME/.bashrc
        echo export GOPATH=$HOME/go >> $HOME/.bashrc
        echo export PATH=$(go env GOPATH)/bin:$PATH >> $HOME/.bashrc
        source ~/.bashrc
        echo "pronto, GO instalado"
    ;;

    2)  sudo tar -C /usr/local -xzf `ls|grep go*.tar.gz | tail -1`
        echo export PATH="$"PATH:/opt/go/bin >> $HOME/.bashrc
        echo export GOPATH=$HOME/go >> $HOME/.bashrc
        echo export PATH=$(go env GOPATH)/bin:$PATH >> $HOME/.bashrc
        source ~/.bashrc
        echo "pronto, GO instalado"
    ;;

    *) sudo tar -C /opt -xzf `ls|grep go*.tar.gz | tail -1`
        echo export PATH="$"PATH:/opt/go/bin >> $HOME/.bashrc
        echo export GOPATH=$HOME/go >> $HOME/.bashrc
        echo export PATH=$(go env GOPATH)/bin:$PATH >> $HOME/.bashrc
        source ~/.bashrc
        echo "pronto, GO instalado"
    ;;

    esac
}

baixarGo(){
    echo tentando baixar go na versao $value
    sudo wget https://dl.google.com/go/go$value.linux-amd64.tar.gz

    if [[ $? -eq 0 ]];then
      confirguarNovoGo 
      else
      echo "Ouve algum problema durante o download"
      echo "Verifique se voce digitiou uma versao disponivel"
      echo "ou sua conexão de rede"
    fi
}

modulosGo(){
    echo "Insira a versao que deseja instalar ex: 1.18.1 ou"
    echo "Digite 0 para listar versoes disponiveis"
    read -p " versao > " value

    case $value in
    0) echo -e "\n\nas seguintes versoes abaixo estão disponiveis:\n\n"
    echo "1.13.9"
    echo "1.13.10"
    echo "1.14"
    echo "1.14.1"
    echo -e "1.18.1\n"
    modulosGo;;
    *) baixarGo ;;
    esac
}

instalarGO(){
    echo "Preparando instalação:"
    echo "Verificando se o go ja foi baixado neste diretorio ..."
    ls|grep go*.tar.gz > /dev/null 2>&1
    if [[ $? -gt 0 ]];then
    echo "go nao encontrado"
    modulosGo
    else
        echo "Um pacote go baixado encontrado"
        echo -n "Deseja instalar " 
        encontrado=`ls|grep go*.tar.gz | tail -1`
        echo $encontrado
        read -p "[y/N] > " instalar

        case $instalar in 
        y)configurarGoEncontrado;;
        n)echo "Certo este pacote nao sera instalado"
        sudo rm -r go*tar.gz
        modulosGo
        ;;
        *)echo "Certo este pacote nao sera instalado"
        sudo rm -r go*tar.gz
        modulosGo
        ;;
        esac
    fi   
}
