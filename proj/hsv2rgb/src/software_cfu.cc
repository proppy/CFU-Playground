/*
 * Copyright 2021 The CFU-Playground Authors
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *      http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

#include <stdint.h>
#include "fast_hsv2rgb.h"
#include "software_cfu.h"

//
// In this function, place C code to emulate your CFU. You can switch between
// hardware and emulated CFU by setting the CFU_SOFTWARE_DEFINED DEFINE in
// the Makefile.
uint32_t software_cfu(int funct3, int funct7, uint32_t rs1, uint32_t rs2)
{
  const uint32_t h = (rs1 >> 16) & 0xffff;
  const uint32_t s = (rs1 >> 8) & 0xff;
  const uint32_t v = rs1 & 0xff;

  uint8_t r, g, b;
  fast_hsv2rgb_32bit(h, s, v, &r, &g, &b);
  return (r << 16) | (g << 8) | b;
}
