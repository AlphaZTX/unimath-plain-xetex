-- Run this Lua script to generate "unimath-plain-xetex-mathalpha.tex".
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

Latin = { {"A","A"}, {"B","B"}, {"C","C"}, {"D","D"}, {"E","E"}, {"F","F"}, {"G","G"},
          {"H","H"}, {"I","I"}, {"J","J"}, {"K","K"}, {"L","L"}, {"M","M"}, {"N","N"},
          {"O","O"}, {"P","P"}, {"Q","Q"}, {"R","R"}, {"S","S"}, {"T","T"},
          {"U","U"}, {"V","V"}, {"W","W"}, {"X","X"}, {"Y","Y"}, {"Z","Z"},
          {"a","a"}, {"b","b"}, {"c","c"}, {"d","d"}, {"e","e"}, {"f","f"}, {"g","g"},
          {"h","h"}, {"i","i"}, {"j","j"}, {"k","k"}, {"l","l"}, {"m","m"}, {"n","n"},
          {"o","o"}, {"p","p"}, {"q","q"}, {"r","r"}, {"s","s"}, {"t","t"},
          {"u","u"}, {"v","v"}, {"w","w"}, {"x","x"}, {"y","y"}, {"z","z"} }

Greek = { {"Α","Alpha"},      {"Β","Beta"},     {"Γ","Gamma"},    {"Δ","Delta"},
          {"Ε","Epsilon"},    {"Ζ","Zeta"},     {"Η","Eta"},      {"Θ","Theta"},
          {"Ι","Iota"},       {"Κ","Kappa"},    {"Λ","Lambda"},   {"Μ","Mu"},
          {"Ν","Nu"},         {"Ξ","Xi"},       {"Ο","Omicron"},  {"Π","Pi"},
          {"Ρ","Rho"},        {"Σ","Sigma"},    {"Τ","Tau"},      {"Υ","Upsilon"},
          {"Φ","Phi"},        {"Χ","Chi"},      {"Ψ","Psi"},      {"Ω","Omega"},
          {"α","alpha"},      {"β","beta"},     {"γ","gamma"},    {"δ","delta"},
          {"ε","varepsilon"}, {"ζ","zeta"},     {"η","eta"},      {"θ","theta"},
          {"ι","iota"},       {"κ","kappa"},    {"λ","lambda"},   {"μ","mu"},
          {"ν","nu"},         {"ξ","xi"},       {"ο","omicron"},  {"π","pi"},
          {"ρ","rho"},        {"ς","varsigma"}, {"σ","sigma"},    {"τ","tau"},
          {"υ","upsilon"},    {"φ","varphi"},   {"χ","chi"},      {"ψ","psi"},
          {"ω","omega"},      {"ϑ","vartheta"}, {"ϕ","phi"},      {"ϖ","varpi"},
          {"ϰ","varkappa"},   {"ϱ","varrho"},   {"ϴ","varTheta"}, {"ϵ","epsilon"} }

Digit = { {"0","zero"},       {"1","one"},      {"2","two"},      {"3","three"},
          {"4","four"},       {"5","five"},     {"6","six"},      {"7","seven"},
          {"8","eight"},      {"9","nine"} }

Partial = { {"∂","partial"}, {"∇","nabla"} }

um_table = assert(kpse.find_file('unicode-math-table', tex))
tmp_alpha_table = "unimath-plain-alphabet.temp"
alpha_table = "unimath-plain-alphabet.tex"

tmp_out = io.open(tmp_alpha_table, "w")
out = io.open(alpha_table, "w+")
out:write(tex_info.."\n")

for templine in io.lines(um_table) do
    if string.match(templine, "\\[mB][bfitsu].*\\mathalpha") then
        tmp_out:write(templine.."\n")
    else if string.match(templine, "\\m[bfitsu].*\\mathord") then
        tmp_out:write(templine.."\n")
    end end
end
tmp_out:close()

function gen_symbol(file, font, alphabet)
    for line in io.lines(file) do
        for _, letter_pair in ipairs(alphabet) do
            if string.match(line, font..letter_pair[2].."[^%a]") then
                -- Format: \UnicodeMathSymbol{<slot>}{<cs>}{<alpha|ord>}{<description>}%
                local char_slot = string.match(line, "{(.-)}")
                out:write("  \\Umathcode `\\"..letter_pair[1].." = 0 \\normalfam "..char_slot.." \n")
            end
        end
    end
end

cs_head = { {"\\rm","\\mup","\\tenrm"}, {"\\it","\\mit","\\tenit"},
            {"\\bf","\\mbf","\\tenbf"}, {"\\sf","\\msans","\\tensf"},
            {"\\tt","\\mtt","\\tentt"}, {"\\bfit","\\mbfit","\\tenbfit"},
            {"\\sfit","\\mitsans","\\tensfit"},
            {"\\sfbf","\\mbfsans","\\tensfbf"},
            {"\\sfbfit","\\mbfitsans","\\tensfbfit"},
            -- The tables below do not contain a text command as the 3rd item:
            {"\\scr","\\mscr"}, {"\\bb","\\Bbb"}, {"\\frak","\\mfrak"},
            {"\\scrbf","\\mbfscr"}, {"\\frakbf","\\mbffrak"}, {"\\bbit","\\mitBbb"} }

for _, cs_pair in ipairs(cs_head) do
    out:write("\\protected\\def"..cs_pair[1].."{%\n")
    gen_symbol(tmp_alpha_table, cs_pair[2], Digit)
    gen_symbol(tmp_alpha_table, cs_pair[2], Latin)
    gen_symbol(tmp_alpha_table, cs_pair[2], Greek)
    gen_symbol(tmp_alpha_table, cs_pair[2], Partial)
    if cs_pair[3] then
        out:write(cs_pair[3])
    end
    out:write("}%\n")
end

out:write("\\endinput")
out:close()

os.remove(tmp_alpha_table)