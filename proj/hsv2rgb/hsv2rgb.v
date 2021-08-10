module __hsv2rgb__hsv2rgb(
  input wire [15:0] h,
  input wire [7:0] s,
  input wire [7:0] v,
  output wire [23:0] out
);
  // lint_off MULTIPLY
  function automatic [15:0] umul16b_8b_x_8b (input reg [7:0] lhs, input reg [7:0] rhs);
    begin
      umul16b_8b_x_8b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  // lint_off MULTIPLY
  function automatic [15:0] umul16b_8b_x_16b (input reg [7:0] lhs, input reg [15:0] rhs);
    begin
      umul16b_8b_x_16b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  // lint_off MULTIPLY
  function automatic [31:0] umul32b_8b_x_32b (input reg [7:0] lhs, input reg [31:0] rhs);
    begin
      umul32b_8b_x_32b = lhs * rhs;
    end
  endfunction
  // lint_on MULTIPLY
  wire [7:0] c__1;
  wire [7:0] bit_slice_340;
  wire [15:0] h_fraction;
  wire [15:0] nh_fraction;
  wire [15:0] umul_345;
  wire [15:0] umul_347;
  wire [31:0] sub_352;
  wire [31:0] sub_353;
  wire [7:0] sextant;
  wire [31:0] u__4;
  wire [31:0] u__1;
  wire [7:0] c__4;
  wire [7:0] c__3;
  wire [7:0] sextant__1;
  wire [7:0] c__2;
  wire eq_374;
  wire eq_375;
  wire [31:0] u__5;
  wire [31:0] concat_377;
  wire [31:0] u__2;
  wire eq_379;
  wire eq_380;
  wire eq_381;
  wire eq_382;
  wire [31:0] u__6;
  wire [31:0] u__3;
  wire [7:0] c__5;
  wire [2:0] concat_389;
  wire [7:0] d;
  wire [7:0] u__7;
  wire [2:0] concat_392;
  wire [2:0] concat_393;
  wire eq_394;
  assign c__1 = 8'h00;
  assign bit_slice_340 = h[7:0];
  assign h_fraction = {c__1, bit_slice_340};
  assign nh_fraction = 16'h0100 - h_fraction;
  assign umul_345 = umul16b_8b_x_8b(s, bit_slice_340);
  assign umul_347 = umul16b_8b_x_16b(s, nh_fraction);
  assign sub_352 = 32'h0000_ff00 - {16'h0000, umul_345};
  assign sub_353 = 32'h0000_ff00 - {16'h0000, umul_347};
  assign sextant = h[15:8];
  assign u__4 = umul32b_8b_x_32b(v, sub_352);
  assign u__1 = umul32b_8b_x_32b(v, sub_353);
  assign c__4 = 8'h00;
  assign c__3 = 8'h00;
  assign sextant__1 = sextant > 8'h05 == 1'h0 ? sextant : 8'h05;
  assign c__2 = 8'h00;
  assign eq_374 = sextant__1 == c__2;
  assign eq_375 = sextant__1 == 8'h05;
  assign u__5 = u__4 + {c__4, u__4[31:8]};
  assign concat_377 = {24'h00_0000, v};
  assign u__2 = u__1 + {c__3, u__1[31:8]};
  assign eq_379 = sextant__1 == 8'h01;
  assign eq_380 = sextant__1 == 8'h02;
  assign eq_381 = sextant__1 == 8'h03;
  assign eq_382 = sextant__1 == 8'h04;
  assign u__6 = u__5 + concat_377;
  assign u__3 = u__2 + concat_377;
  assign c__5 = 8'h00;
  assign concat_389 = {eq_382, eq_379, eq_374 | eq_375};
  assign d = u__6[23:16];
  assign u__7 = u__3[23:16];
  assign concat_392 = {eq_381, eq_379 | eq_380, eq_374};
  assign concat_393 = {eq_375, eq_381 | eq_382, eq_380};
  assign eq_394 = s == c__5;
  assign out = {eq_394 == 1'h0 ? v & {8{concat_389[0]}} | d & {8{concat_389[1]}} | u__7 & {8{concat_389[2]}} : v, eq_394 == 1'h0 ? u__7 & {8{concat_392[0]}} | v & {8{concat_392[1]}} | d & {8{concat_392[2]}} : v, eq_394 == 1'h0 ? u__7 & {8{concat_393[0]}} | v & {8{concat_393[1]}} | d & {8{concat_393[2]}} : v};
endmodule
