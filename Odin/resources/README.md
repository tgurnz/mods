In this folder there is a file named <code>SS_DL.dll</code>, <br/>
with some useful (for Odin) functions, it should be placed in the same folder as the odin exe-file.<br/>
This <code>SS_DL.dll</code> was taken from Odin v3.13.1.0 .

<hr/>

<h3><em>SS_DL.dll</em> Exported Functions List</h3>
<table border="1" cellpadding="3"><tr>
<th>Function Name
<th>Address
<th>Relative Address
<th>Ordinal
<tr><td nowrap>LZ4_compress<td nowrap>0x1004ad20<td nowrap>0x0004ad20<td nowrap>1 (0x1)
<tr><td nowrap>LZ4_compress_continue<td nowrap>0x1004ae00<td nowrap>0x0004ae00<td nowrap>3 (0x3)
<tr><td nowrap>LZ4_compress_default<td nowrap>0x100468b0<td nowrap>0x000468b0<td nowrap>4 (0x4)
<tr><td nowrap>LZ4_compress_destSize<td nowrap>0x10046ec0<td nowrap>0x00046ec0<td nowrap>5 (0x5)
<tr><td nowrap>LZ4_compress_fast<td nowrap>0x10046860<td nowrap>0x00046860<td nowrap>6 (0x6)
<tr><td nowrap>LZ4_compress_fast_continue<td nowrap>0x100470d0<td nowrap>0x000470d0<td nowrap>7 (0x7)
<tr><td nowrap>LZ4_compress_fast_extState<td nowrap>0x100459f0<td nowrap>0x000459f0<td nowrap>8 (0x8)
<tr><td nowrap>LZ4_compress_limitedOutput<td nowrap>0x100468b0<td nowrap>0x000468b0<td nowrap>9 (0x9)
<tr><td nowrap>LZ4_compress_limitedOutput_continue<td nowrap>0x1004ade0<td nowrap>0x0004ade0<td nowrap>10 (0xa)
<tr><td nowrap>LZ4_compress_limitedOutput_withState<td nowrap>0x1004ad70<td nowrap>0x0004ad70<td nowrap>11 (0xb)
<tr><td nowrap>LZ4_compress_withState<td nowrap>0x1004ad90<td nowrap>0x0004ad90<td nowrap>12 (0xc)
<tr><td nowrap>LZ4_compressBound<td nowrap>0x100459b0<td nowrap>0x000459b0<td nowrap>2 (0x2)
<tr><td nowrap>LZ4_create<td nowrap>0x1004aeb0<td nowrap>0x0004aeb0<td nowrap>13 (0xd)
<tr><td nowrap>LZ4_createStream<td nowrap>0x10046f10<td nowrap>0x00046f10<td nowrap>14 (0xe)
<tr><td nowrap>LZ4_createStreamDecode<td nowrap>0x10048cb0<td nowrap>0x00048cb0<td nowrap>15 (0xf)
<tr><td nowrap>LZ4_decompress_fast<td nowrap>0x10048a50<td nowrap>0x00048a50<td nowrap>16 (0x10)
<tr><td nowrap>LZ4_decompress_fast_continue<td nowrap>0x100493f0<td nowrap>0x000493f0<td nowrap>17 (0x11)
<tr><td nowrap>LZ4_decompress_fast_usingDict<td nowrap>0x1004a4b0<td nowrap>0x0004a4b0<td nowrap>18 (0x12)
<tr><td nowrap>LZ4_decompress_fast_withPrefix64k<td nowrap>0x10048a50<td nowrap>0x00048a50<td nowrap>19 (0x13)
<tr><td nowrap>LZ4_decompress_safe<td nowrap>0x10048440<td nowrap>0x00048440<td nowrap>20 (0x14)
<tr><td nowrap>LZ4_decompress_safe_continue<td nowrap>0x10048cf0<td nowrap>0x00048cf0<td nowrap>21 (0x15)
<tr><td nowrap>LZ4_decompress_safe_partial<td nowrap>0x10048740<td nowrap>0x00048740<td nowrap>22 (0x16)
<tr><td nowrap>LZ4_decompress_safe_usingDict<td nowrap>0x100499e0<td nowrap>0x000499e0<td nowrap>23 (0x17)
<tr><td nowrap>LZ4_decompress_safe_withPrefix64k<td nowrap>0x1004af30<td nowrap>0x0004af30<td nowrap>24 (0x18)
<tr><td nowrap>LZ4_freeStream<td nowrap>0x10046f60<td nowrap>0x00046f60<td nowrap>25 (0x19)
<tr><td nowrap>LZ4_freeStreamDecode<td nowrap>0x10046f60<td nowrap>0x00046f60<td nowrap>26 (0x1a)
<tr><td nowrap>LZ4_loadDict<td nowrap>0x10046f80<td nowrap>0x00046f80<td nowrap>27 (0x1b)
<tr><td nowrap>LZ4_resetStream<td nowrap>0x10046f40<td nowrap>0x00046f40<td nowrap>28 (0x1c)
<tr><td nowrap>LZ4_resetStreamState<td nowrap>0x1004ae70<td nowrap>0x0004ae70<td nowrap>29 (0x1d)
<tr><td nowrap>LZ4_saveDict<td nowrap>0x100483f0<td nowrap>0x000483f0<td nowrap>30 (0x1e)
<tr><td nowrap>LZ4_setStreamDecode<td nowrap>0x10048cc0<td nowrap>0x00048cc0<td nowrap>31 (0x1f)
<tr><td nowrap>LZ4_sizeofState<td nowrap>0x100459e0<td nowrap>0x000459e0<td nowrap>32 (0x20)
<tr><td nowrap>LZ4_sizeofStreamState<td nowrap>0x100459e0<td nowrap>0x000459e0<td nowrap>33 (0x21)
<tr><td nowrap>LZ4_slideInputBuffer<td nowrap>0x1004aee0<td nowrap>0x0004aee0<td nowrap>34 (0x22)
<tr><td nowrap>LZ4_uncompress<td nowrap>0x1004ae50<td nowrap>0x0004ae50<td nowrap>35 (0x23)
<tr><td nowrap>LZ4_uncompress_unknownOutputSize<td nowrap>0x1004ae60<td nowrap>0x0004ae60<td nowrap>36 (0x24)
<tr><td nowrap>LZ4_versionNumber<td nowrap>0x10045990<td nowrap>0x00045990<td nowrap>37 (0x25)
<tr><td nowrap>LZ4_versionString<td nowrap>0x100459a0<td nowrap>0x000459a0<td nowrap>38 (0x26)
<tr><td nowrap>Odin_CheckMD5<td nowrap>0x10016ef0<td nowrap>0x00016ef0<td nowrap>39 (0x27)
<tr><td nowrap>Odin_Create<td nowrap>0x10016c70<td nowrap>0x00016c70<td nowrap>40 (0x28)
<tr><td nowrap>Odin_Destroy<td nowrap>0x10016ff0<td nowrap>0x00016ff0<td nowrap>41 (0x29)
<tr><td nowrap>Odin_EnableMD5Check<td nowrap>0x10016d30<td nowrap>0x00016d30<td nowrap>42 (0x2a)
<tr><td nowrap>Odin_EndDownload<td nowrap>0x10016fd0<td nowrap>0x00016fd0<td nowrap>43 (0x2b)
<tr><td nowrap>Odin_Init<td nowrap>0x10016cb0<td nowrap>0x00016cb0<td nowrap>44 (0x2c)
<tr><td nowrap>Odin_SetBinaryPath<td nowrap>0x10016e20<td nowrap>0x00016e20<td nowrap>45 (0x2d)
<tr><td nowrap>Odin_SetDumpPath<td nowrap>0x10016df0<td nowrap>0x00016df0<td nowrap>46 (0x2e)
<tr><td nowrap>Odin_SetExtraBinaryPath<td nowrap>0x10016ec0<td nowrap>0x00016ec0<td nowrap>47 (0x2f)
<tr><td nowrap>Odin_SetOption<td nowrap>0x10016d50<td nowrap>0x00016d50<td nowrap>48 (0x30)
<tr><td nowrap>Odin_SetOptionErase<td nowrap>0x10016d80<td nowrap>0x00016d80<td nowrap>49 (0x31)
<tr><td nowrap>Odin_SetOptionReboot<td nowrap>0x10016d70<td nowrap>0x00016d70<td nowrap>50 (0x32)
<tr><td nowrap>Odin_SetPacketSize<td nowrap>0x10016d90<td nowrap>0x00016d90<td nowrap>51 (0x33)
<tr><td nowrap>Odin_SetPitPath<td nowrap>0x10016dc0<td nowrap>0x00016dc0<td nowrap>52 (0x34)
<tr><td nowrap>Odin_SetSalesCode<td nowrap>0x10003650<td nowrap>0x00003650<td nowrap>53 (0x35)
<tr><td nowrap>Odin_StartDownload<td nowrap>0x10016f50<td nowrap>0x00016f50<td nowrap>54 (0x36)
<tr><td nowrap>Odin_StartMultiDownload<td nowrap>0x10016f90<td nowrap>0x00016f90<td nowrap>55 (0x37)
</table>
