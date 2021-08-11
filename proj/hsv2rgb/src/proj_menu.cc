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

#include "proj_menu.h"
#include "fast_hsv2rgb.h"

#include <stdio.h>

#include "cfu.h"
#include "menu.h"
#include "rgb.h"

namespace {

// Template Fn

void do_hello_world(void) { puts("Hello, World!!!\n"); }

// Test template instruction
void do_exercise_cfu_op0(void) {
  puts("\nExercise CFU Op0\n");
  const uint32_t s = 255;
  const uint32_t v = 255;
  const uint32_t hstep = 8;
  int count = 0;
  for (uint32_t h = 0; h < 256 * 6; h+=hstep) {
    uint8_t r, g, b;
    fast_hsv2rgb_32bit(h, s, v, &r, &g, &b);
    uint32_t rgb = r << 16 | g << 8 | b;
    uint32_t hsv = h << 16 | s << 8 | v;
    uint32_t cfu_rgb = cfu_op0(0, hsv, 0);
    printf("hsv: %08lx cfu=%08lx\n", hsv, cfu_rgb);
    if (cfu_rgb != rgb) {
      printf("\n***FAIL %08lx %08lx\n", cfu_rgb, rgb);
      return;
    }
    count++;
  }
  printf("Performed %d comparisons", count);
}

void do_rgb_test(void) {
  rgb_init();
  const uint32_t s = 255;
  const uint32_t v = 255;
  const uint32_t hstep = 1;
  for (uint32_t h = 0; h < 256 * 6; h+=hstep) {
    uint32_t hsv = h << 16 | s << 8 | v;
    uint32_t cfu_rgb = cfu_op0(0, hsv, 0);
    uint32_t r = cfu_rgb >> 16 & 0xff;
    uint32_t g = cfu_rgb >> 8 & 0xff;
    uint32_t b = cfu_rgb & 0xff;
    rgb_set(uint8_t(r), uint8_t(g), uint8_t(b));
    printf("h:%08lx => r:%08lx g:%08lx b:%08lx\n", h, r, g, b);
  }
}

struct Menu MENU = {
    "Project Menu",
    "project",
    {
        MENU_ITEM('0', "exercise cfu op0", do_exercise_cfu_op0),
        MENU_ITEM('1', "rgb test", do_rgb_test),
        MENU_ITEM('h', "say Hello", do_hello_world),
        MENU_END,
    },
};

};  // anonymous namespace

extern "C" void do_proj_menu() { menu_run(&MENU); }
