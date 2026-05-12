// SPDX-License-Identifier: MIT
pragma solidity ^0.8.25;

/**
 * @title SimpleStorage
 * @dev Estudo inicial sobre variáveis de estado e funções de leitura.
 */
contract SimpleStorage {
    // Variável de estado (armazenada permanentemente na blockchain)
    uint256 public favoriteNumber;

    // Função que altera o estado (Gasta GAS)
    function store(uint256 _favoriteNumber) public {
        favoriteNumber = _favoriteNumber;
    }

    // Função que apenas lê o estado (0 GAS se chamada externamente)
    function retrieve() public view returns (uint256) {
        return favoriteNumber;
    }
}
