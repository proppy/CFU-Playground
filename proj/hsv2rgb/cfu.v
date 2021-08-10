// Copyright 2021 The CFU-Playground Authors
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

`include "hsv2rgb.v"


module Cfu (
  input               cmd_valid,
  output              cmd_ready,
  input      [9:0]    cmd_payload_function_id,
  input      [31:0]   cmd_payload_inputs_0,
  input      [31:0]   cmd_payload_inputs_1,
  output              rsp_valid,
  input               rsp_ready,
  output              rsp_payload_response_ok,
  output     [31:0]   rsp_payload_outputs_0,
  input               reset,
  input               clk
);

  // Trivial handshaking for a combinational CFU
  assign rsp_valid = cmd_valid;
  assign cmd_ready = rsp_ready;
  assign rsp_payload_response_ok = 1'b1;

  wire [15:0] 	      h;
  wire [7:0] 	      s;
  wire [7:0] 	      v;
  wire [31:0] 	      rgb;

  assign h = cmd_payload_inputs_0[31:16];
  assign s = cmd_payload_inputs_0[15:8];
  assign v = cmd_payload_inputs_0[7:0];
  __hsv2rgb__hsv2rgb hsv2rgb_1(h, s, v, rgb);
  assign rsp_payload_outputs_0 = rgb;

endmodule
