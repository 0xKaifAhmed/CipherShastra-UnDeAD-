pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;
import "../lib/forge-std/src/Test.sol";
import "src/UnDeAD.sol";


contract TestUndead is Test {
    undead public Undead;
        bytes20 want = bytes20(0x00000000000000000000000000000000000B100D);
        bytes20 mask = bytes20(0x00000000000000000000000000000000000fFFFf);
        uint256 wordLength = 5;

    function setUp() public {

        Undead = new undead(want, mask , wordLength);
    }

    function testAlive() public{

        /*
        #EVM opcode
        PUSH6 0x556e44654144
        PUSH1 00
        MSTORE
        PUSH1 20
        PUSH1 00
        RETURN

        #runtime bytecode
        65556e4465414460005260206000f3
        */

        address Mortal = address(0xb100d);
        
        //Mapping byteCode to the address using forge cheetcode
        vm.etch(
            Mortal,
            hex"65556e4465414460005260206000f3"
        );

        Undead.deadOrAlive(Mortal);
    }

  
}


/*
#Constructor argumets
_want       (bytes20): 0x00000000000000000000000000000000000b100d
_mask       (bytes20): 0x00000000000000000000000000000000000fffff
_wordLength (uint256): 5
*/