// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

contract CofrePessoal {
    mapping(address => uint256) public saldos;

    event DepositoRealizado(address indexed dono, uint256 valor);
    event SaqueRealizado(address indexed dono, uint256 valor);

    function depositar() public payable {
        require(msg.value > 0, "Valor invalido");
        saldos[msg.sender] += msg.value;
        emit DepositoRealizado(msg.sender, msg.value);
    }

    function sacar(uint256 _valor) public {
        require(saldos[msg.sender] >= _valor, "Saldo insuficiente");
        
        // Padrão CEI: Atualiza o estado ANTES da interação
        saldos[msg.sender] -= _valor;

        (bool sucesso, ) = payable(msg.sender).call{value: _valor}("");
        require(sucesso, "Falha no envio");

        emit SaqueRealizado(msg.sender, _valor);
    }

    function consultarMeuSaldo() public view returns (uint256) {
        return saldos[msg.sender];
    }
}
