// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/**
 * @title CofreMultisigZarelli
 * @author Leonardo Zarelli (Ecosystem One)
 * @notice Implementação de carteira multi-assinada (Mecânica X de Y)
 */
contract CofreMultisigZarelli {
    event Deposito(address indexed remetente, uint256 valor);
    event PropostaEnviada(uint256 indexed txIndex, address indexed proponente, address para, uint256 valor);
    event ConfirmacaoRecebida(uint256 indexed txIndex, address indexed proprietario);
    event TransacaoExecutada(uint256 indexed txIndex);

    struct Transacao {
        address para;
        uint256 valor;
        bytes dados;
        bool executada;
        uint256 numConfirmacoes;
    }

    address[] public proprietarios;
    mapping(address => bool) public ehProprietario;
    uint256 public numConfirmacoesRequeridas;
    Transacao[] public transacoes;
    mapping(uint256 => mapping(address => bool)) public confirmacoes;

    modifier apenasProprietario() {
        require(ehProprietario[msg.sender], "Nao eh proprietario");
        _;
    }

    constructor(address[] memory _proprietarios, uint256 _requeridas) {
        require(_proprietarios.length > 0, "Proprietarios necessarios");
        require(_requeridas > 0 && _requeridas <= _proprietarios.length, "Numero de assinaturas invalido");

        for (uint256 i = 0; i < _proprietarios.length; i++) {
            address proprietario = _proprietarios[i];
            require(proprietario != address(0), "Proprietario invalido");
            require(!ehProprietario[proprietario], "Proprietario duplicado");

            ehProprietario[proprietario] = true;
            proprietarios.push(proprietario);
        }
        numConfirmacoesRequeridas = _requeridas;
    }

    receive() external payable {
        emit Deposito(msg.sender, msg.value);
    }

    function proporTransacao(address _para, uint256 _valor, bytes memory _dados) public apenasProprietario {
        uint256 txIndex = transacoes.length;
        transacoes.push(Transacao({
            para: _para,
            valor: _valor,
            dados: _dados,
            executada: false,
            numConfirmacoes: 0
        }));
        emit PropostaEnviada(txIndex, msg.sender, _para, _valor);
    }

    function confirmarTransacao(uint256 _txIndex) public apenasProprietario {
        require(_txIndex < transacoes.length, "Inexistente");
        require(!transacoes[_txIndex].executada, "Executada");
        require(!confirmacoes[_txIndex][msg.sender], "Ja confirmou");

        transacoes[_txIndex].numConfirmacoes += 1;
        confirmacoes[_txIndex][msg.sender] = true;
        emit ConfirmacaoRecebida(_txIndex, msg.sender);
    }

    function executarTransacao(uint256 _txIndex) public {
        Transacao storage transacao = transacoes[_txIndex];
        require(transacao.numConfirmacoes >= numConfirmacoesRequeridas, "Quorum insuficiente");
        require(!transacao.executada, "Ja executada");

        transacao.executada = true;

        (bool sucesso, ) = transacao.para.call{value: transacao.valor}(transacao.dados);
        require(sucesso, "Falha na execucao");

        emit TransacaoExecutada(_txIndex);
    }
}
