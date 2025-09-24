#ifndef MATHBASIC_H
#define MATHBASIC_H

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h> // for uint8_t, uint16_t, int32_t
// =========================
// Addition
// =========================

/**
 * @brief Add two 8-bit unsigned integers.
 * @param a First operand
 * @param b Second operand
 * @return Sum of a and b
 */
uint8_t add_u8(uint8_t a, uint8_t b);

/**
 * @brief Add two 16-bit unsigned integers.
 */
uint16_t add_u16(uint16_t a, uint16_t b);

/**
 * @brief Add two 32-bit signed integers.
 */
int32_t add_i32(int32_t a, int32_t b);

/**
 * @brief Add two 64-bit floating-point numbers.
 */
double add_f64(double a, double b);


// =========================
// Subtraction
// =========================

/**
 * @brief Subtract two 8-bit unsigned integers.
 */
uint8_t sub_u8(uint8_t a, uint8_t b);

/**
 * @brief Subtract two 16-bit unsigned integers.
 */
uint16_t sub_u16(uint16_t a, uint16_t b);

/**
 * @brief Subtract two 32-bit signed integers.
 */
int32_t sub_i32(int32_t a, int32_t b);

/**
 * @brief Subtract two 64-bit floating-point numbers.
 */
double sub_f64(double a, double b);


// =========================
// Multiplication
// =========================

/**
 * @brief Multiply two 8-bit unsigned integers.
 */
uint8_t mult_u8(uint8_t a, uint8_t b);

/**
 * @brief Multiply two 16-bit unsigned integers.
 */
uint16_t mult_u16(uint16_t a, uint16_t b);

/**
 * @brief Multiply two 32-bit signed integers.
 */
int32_t mult_i32(int32_t a, int32_t b);

/**
 * @brief Multiply two 64-bit floating-point numbers.
 */
double mult_f64(double a, double b);


// =========================
// Division
// =========================

/**
 * @brief Divide two 8-bit unsigned integers.
 * @note Returns 0 if division fails.
 */
uint8_t divide_u8(uint8_t a, uint8_t b);

/**
 * @brief Divide two 16-bit unsigned integers.
 * @note Returns 0 if division fails.
 */
uint16_t divide_u16(uint16_t a, uint16_t b);

/**
 * @brief Divide two 32-bit signed integers.
 * @note Returns 0 if division fails.
 */
int32_t divide_i32(int32_t a, int32_t b);

/**
 * @brief Divide two 64-bit floating-point numbers.
 * @note Returns 0.0 if division fails.
 */
double divide_f64(double a, double b);


// =========================
// Power
// =========================

/**
 * @brief Raise an 8-bit unsigned integer to the power of another.
 */
uint8_t powx_u8(uint8_t a, uint8_t b);

/**
 * @brief Raise a 16-bit unsigned integer to the power of another.
 */
uint16_t powx_u16(uint16_t a, uint16_t b);

/**
 * @brief Raise a 32-bit signed integer to the power of another.
 */
int32_t powx_i32(int32_t a, int32_t b);

/**
 * @brief Raise a 64-bit floating-point number to the power of another.
 */
double powx_f64(double a, double b);
#ifdef __cplusplus
}
#endif

#endif