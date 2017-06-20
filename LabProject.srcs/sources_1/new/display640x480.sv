`define WholeLine  800   // x lies in [0..WholeLine-1]
`define WholeFrame 525   // y lies in [0..WholeFrame-1]

`define xpixels 640
`define ypixels 480

`define xbits $clog2(`WholeLine)  // how many bits needed to count x?
`define ybits $clog2(`WholeFrame) // how many bits needed to count y?

`define xb $clog2(`xpixels)
`define yb $clog2(`ypixels)

`define nchar 16
`define char_code_bits 4
`define charx 16
`define chary 16
`define charxbits 4
`define charybits 4
`define nx 40
`define ny 30

`define hFrontPorch 16
`define hBackPorch 48
`define hSyncPulse 96
`define vFrontPorch 10
`define vBackPorch 33
`define vSyncPulse 2

`define hSyncPolarity 1'b1
`define vSyncPolarity 1'b1

`define hSyncStart (`WholeLine - `hBackPorch - `hSyncPulse)
`define hSyncEnd (`hSyncStart + `hSyncPulse - 1)
`define vSyncStart (`WholeFrame - `vBackPorch - `vSyncPulse)
`define vSyncEnd (`vSyncStart + `vSyncPulse - 1)

`define hVisible (`WholeLine  - `hFrontPorch - `hSyncPulse - `hBackPorch)
`define vVisible (`WholeFrame - `vFrontPorch - `vSyncPulse - `vBackPorch)