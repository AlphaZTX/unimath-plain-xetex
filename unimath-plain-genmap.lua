-- Run this Lua script to generate "unimath-plain-xetex-alphabet.tex".
-- This script needs kpathsea library which is provided by LuaTeX.
-- You can "luatex" a file including 
--     \directlua{dofile("unimath-plain-genalphabet.lua")}

tex_info = [===[%% <FILE> unimath-plain-xetex-alphabet
%% ******************************************************
%% * This work may be distributed and/or modified under *
%% * the conditions of the LaTeX Project Public License *
%% *     http://www.latex-project.org/lppl.txt          *
%% * either version 1.3c of this license or any later   *
%% * version.                                           *
%% ******************************************************]===]

Latin = { {"A", "0041", "A"}, {"B", "0042", "B"}, {"C", "0043", "C"}, {"D", "0044", "D"},
          {"E", "0045", "E"}, {"F", "0046", "F"}, {"G", "0047", "G"}, {"H", "0048", "H"},
          {"I", "0049", "I"}, {"J", "004A", "J"}, {"K", "004B", "K"}, {"L", "004C", "L"},
          {"M", "004D", "M"}, {"N", "004E", "N"}, {"O", "004F", "O"}, {"P", "0050", "P"},
          {"Q", "0051", "Q"}, {"R", "0052", "R"}, {"S", "0053", "S"}, {"T", "0054", "T"},
          {"U", "0055", "U"}, {"V", "0056", "V"}, {"W", "0057", "W"}, {"X", "0058", "X"},
          {"Y", "0059", "Y"}, {"Z", "005A", "Z"}, {"a", "0061", "a"}, {"b", "0062", "b"},
          {"c", "0063", "c"}, {"d", "0064", "d"}, {"e", "0065", "e"}, {"f", "0066", "f"},
          {"g", "0067", "g"}, {"h", "0068", "h"}, {"i", "0069", "i"}, {"j", "006A", "j"},
          {"k", "006B", "k"}, {"l", "006C", "l"}, {"m", "006D", "m"}, {"n", "006E", "n"},
          {"o", "006F", "o"}, {"p", "0070", "p"}, {"q", "0071", "q"}, {"r", "0072", "r"},
          {"s", "0073", "s"}, {"t", "0074", "t"}, {"u", "0075", "u"}, {"v", "0076", "v"},
          {"w", "0077", "w"}, {"x", "0078", "x"}, {"y", "0079", "y"}, {"z", "007A", "z"} }

Greek = { {"Α", "0391", "Alpha"},    {"Β", "0392", "Beta"},       {"Γ", "0393", "Gamma"},
          {"Δ", "0394", "Delta"},    {"Ε", "0395", "Epsilon"},    {"Ζ", "0396", "Zeta"},
          {"Η", "0397", "Eta"},      {"Θ", "0398", "Theta"},      {"Ι", "0399", "Iota"},
          {"Κ", "039A", "Kappa"},    {"Λ", "039B", "Lambda"},     {"Μ", "039C", "Mu"},
          {"Ν", "039D", "Nu"},       {"Ξ", "039E", "Xi"},         {"Ο", "039F", "Omicron"},
          {"Π", "03A0", "Pi"},       {"Ρ", "03A1", "Rho"},        {"Σ", "03A3", "Sigma"},
          {"Τ", "03A4", "Tau"},      {"Υ", "03A5", "Upsilon"},    {"Φ", "03A6", "Phi"},
          {"Χ", "03A7", "Chi"},      {"Ψ", "03A8", "Psi"},        {"Ω", "03A9", "Omega"},
          {"α", "03B1", "alpha"},    {"β", "03B2", "beta"},       {"γ", "03B3", "gamma"},
          {"δ", "03B4", "delta"},    {"ε", "03B5", "varepsilon"}, {"ζ", "03B6", "zeta"},
          {"η", "03B7", "eta"},      {"θ", "03B8", "theta"},      {"ι", "03B9", "iota"},
          {"κ", "03BA", "kappa"},    {"λ", "03BB", "lambda"},     {"μ", "03BC", "mu"},
          {"ν", "03BD", "nu"},       {"ξ", "03BE", "xi"},         {"ο", "03BF", "omicron"},
          {"π", "03C0", "pi"},       {"ρ", "03C1", "rho"},        {"ς", "03C2", "varsigma"},
          {"σ", "03C3", "sigma"},    {"τ", "03C4", "tau"},        {"υ", "03C5", "upsilon"},
          {"φ", "03C6", "varphi"},   {"χ", "03C7", "chi"},        {"ψ", "03C8", "psi"},
          {"ω", "03C9", "omega"},    {"ϑ", "03D1", "vartheta"},   {"ϕ", "03D5", "phi"},
          {"ϖ", "03D6", "varpi"},    {"ϰ", "03F0", "varkappa"},   {"ϱ", "03F1", "varrho"},
          {"ϴ", "03F4", "varTheta"}, {"ϵ", "03F5", "epsilon"} }

Digit = { {"0", "0030", "zero"},     {"1", "0031", "one"},        {"2", "0032", "two"},
          {"3", "0033", "three"},    {"4", "0034", "four"},       {"5", "0035", "five"},
          {"6", "0036", "six"},      {"7", "0037", "seven"},      {"8", "0038", "eight"},
          {"9", "0039", "nine"}}

Partial = { {"∂", "2202", "partial"}, {"∇", "2207", "nabla"} }

um_table = assert(kpse.find_file('unicode-math-table', tex))
tmp_alpha_table = "unimath-plain-alphabet.temp"

tmp_out = io.open(tmp_alpha_table, "w")

for templine in io.lines(um_table) do
    if string.match(templine, "\\[mB][bfitsu].*\\mathalpha") then
        tmp_out:write(templine.."\n")
    elseif string.match(templine, "\\m[bfitsu].*\\mathord") then
        tmp_out:write(templine.."\n")
    elseif string.match(templine, "\\Planckconst") then
        tmp_out:write(templine:gsub("\\Planckconst", "\\mith       ").."\n")
    end
end
tmp_out:close()

cs_head = { -- {"rm","\\mup","\\tenrm"}, -- this pair can be ignored
            {"it","\\mit","\\tenit"},
            {"bf","\\mbf","\\tenbf"}, {"sf","\\msans","\\tensf"},
            {"tt","\\mtt","\\tentt"}, {"bfit","\\mbfit","\\tenbfit"},
            {"sfit","\\mitsans","\\tensfit"},
            {"sfbf","\\mbfsans","\\tensfbf"},
            {"sfbfit","\\mbfitsans","\\tensfbfit"},
            -- The tables below do not contain a text command as the 3rd item:
            {"scr","\\mscr"},     {"bb","\\Bbb"},         {"frak","\\mfrak"},
            {"scrbf","\\mbfscr"}, {"frakbf","\\mbffrak"}, {"bbit","\\mitBbb"} }

map_head = [===[pass(Unicode)

LHSName "ascii_char"
RHSName "unicode_char"

]===]

function gen_symbol(file, font, alphabet)
    for line in io.lines(file) do
        for _, letter_pair in ipairs(alphabet) do
            if string.match(line, font..letter_pair[3].."[^%a]") then
                -- Format: \UnicodeMathSymbol{<slot>}{<cs>}{<alpha|ord>}{<description>}%
                local char_slot = (string.match(line, "{(.-)}")):gsub("\"","")
                if ("0"..letter_pair[2]) ~= char_slot then
                    out:write("U+"..letter_pair[2].." <> U+"..char_slot.."\n")
                end
            end
        end
    end
end

for _, cs_pair in ipairs(cs_head) do
    out = io.open("unimath-"..cs_pair[1]..".map", "w+")
    out:write(map_head)
    gen_symbol(tmp_alpha_table, cs_pair[2], Digit)
    gen_symbol(tmp_alpha_table, cs_pair[2], Latin)
    gen_symbol(tmp_alpha_table, cs_pair[2], Greek)
    gen_symbol(tmp_alpha_table, cs_pair[2], Partial)
    out:close()
end

os.remove(tmp_alpha_table)

batch_command = [===[teckit_compile unimath-it.map -o unimath-it.tec
teckit_compile unimath-bf.map -o unimath-bf.tec
teckit_compile unimath-sf.map -o unimath-sf.tec
teckit_compile unimath-tt.map -o unimath-tt.tec
teckit_compile unimath-bfit.map -o unimath-bfit.tec
teckit_compile unimath-sfit.map -o unimath-sfit.tec
teckit_compile unimath-sfbf.map -o unimath-sfbf.tec
teckit_compile unimath-sfbfit.map -o unimath-sfbfit.tec
teckit_compile unimath-scr.map -o unimath-scr.tec
teckit_compile unimath-bb.map -o unimath-bb.tec
teckit_compile unimath-frak.map -o unimath-frak.tec
teckit_compile unimath-scrbf.map -o unimath-scrbf.tec
teckit_compile unimath-frakbf.map -o unimath-frakbf.tec
teckit_compile unimath-bbit.map -o unimath-bbit.tec
]===]