package com.bestlalala.calculator;

import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.assertEquals;

public class CalculatorServiceTest {
    private CalculatorService calculatorService = new CalculatorService();
    @Test
    public void testSum(){
        assertEquals(5, calculatorService.sum(2, 3));
    }
}

