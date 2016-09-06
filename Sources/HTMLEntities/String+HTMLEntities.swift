/*
 * Copyright IBM Corporation 2016
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

/// Generated from the list of HTML4 entities here:
/// https://www.w3.org/TR/html4/sgml/entities.html

private let html4encode: [Character: String] = [
    // ISO 8859-1 characters
    // https://www.w3.org/TR/html4/sgml/entities.html#iso-88591
    "\u{00A0}":"&nbsp;","\u{00A1}":"&iexcl;","\u{00A2}":"&cent;","\u{00A3}":"&pound;","\u{00A4}":"&curren;","\u{00A5}":"&yen;","\u{00A6}":"&brvbar;","\u{00A7}":"&sect;","\u{00A8}":"&uml;","\u{00A9}":"&copy;","\u{00AA}":"&ordf;","\u{00AB}":"&laquo;","\u{00AC}":"&not;","\u{00AD}":"&shy;","\u{00AE}":"&reg;","\u{00AF}":"&macr;","\u{00B0}":"&deg;","\u{00B1}":"&plusmn;","\u{00B2}":"&sup2;","\u{00B3}":"&sup3;","\u{00B4}":"&acute;","\u{00B5}":"&micro;","\u{00B6}":"&para;","\u{00B7}":"&middot;","\u{00B8}":"&cedil;","\u{00B9}":"&sup1;","\u{00BA}":"&ordm;","\u{00BB}":"&raquo;","\u{00BC}":"&frac14;","\u{00BD}":"&frac12;","\u{00BE}":"&frac34;","\u{00BF}":"&iquest;","\u{00C0}":"&Agrave;","\u{00C1}":"&Aacute;","\u{00C2}":"&Acirc;","\u{00C3}":"&Atilde;","\u{00C4}":"&Auml;","\u{00C5}":"&Aring;","\u{00C6}":"&AElig;","\u{00C7}":"&Ccedil;","\u{00C8}":"&Egrave;","\u{00C9}":"&Eacute;","\u{00CA}":"&Ecirc;","\u{00CB}":"&Euml;","\u{00CC}":"&Igrave;","\u{00CD}":"&Iacute;","\u{00CE}":"&Icirc;","\u{00CF}":"&Iuml;","\u{00D0}":"&ETH;","\u{00D1}":"&Ntilde;","\u{00D2}":"&Ograve;","\u{00D3}":"&Oacute;","\u{00D4}":"&Ocirc;","\u{00D5}":"&Otilde;","\u{00D6}":"&Ouml;","\u{00D7}":"&times;","\u{00D8}":"&Oslash;","\u{00D9}":"&Ugrave;","\u{00DA}":"&Uacute;","\u{00DB}":"&Ucirc;","\u{00DC}":"&Uuml;","\u{00DD}":"&Yacute;","\u{00DE}":"&THORN;","\u{00DF}":"&szlig;","\u{00E0}":"&agrave;","\u{00E1}":"&aacute;","\u{00E2}":"&acirc;","\u{00E3}":"&atilde;","\u{00E4}":"&auml;","\u{00E5}":"&aring;","\u{00E6}":"&aelig;","\u{00E7}":"&ccedil;","\u{00E8}":"&egrave;","\u{00E9}":"&eacute;","\u{00EA}":"&ecirc;","\u{00EB}":"&euml;","\u{00EC}":"&igrave;","\u{00ED}":"&iacute;","\u{00EE}":"&icirc;","\u{00EF}":"&iuml;","\u{00F0}":"&eth;","\u{00F1}":"&ntilde;","\u{00F2}":"&ograve;","\u{00F3}":"&oacute;","\u{00F4}":"&ocirc;","\u{00F5}":"&otilde;","\u{00F6}":"&ouml;","\u{00F7}":"&divide;","\u{00F8}":"&oslash;","\u{00F9}":"&ugrave;","\u{00FA}":"&uacute;","\u{00FB}":"&ucirc;","\u{00FC}":"&uuml;","\u{00FD}":"&yacute;","\u{00FE}":"&thorn;","\u{00FF}":"&yuml;",

    // Symbols, mathematical symbols, and Greek letters
    // https://www.w3.org/TR/html4/sgml/entities.html#h-24.3.1
    "\u{0192}":"&fnof;","\u{0391}":"&Alpha;","\u{0392}":"&Beta;","\u{0393}":"&Gamma;","\u{0394}":"&Delta;","\u{0395}":"&Epsilon;","\u{0396}":"&Zeta;","\u{0397}":"&Eta;","\u{0398}":"&Theta;","\u{0399}":"&Iota;","\u{039A}":"&Kappa;","\u{039B}":"&Lambda;","\u{039C}":"&Mu;","\u{039D}":"&Nu;","\u{039E}":"&Xi;","\u{039F}":"&Omicron;","\u{03A0}":"&Pi;","\u{03A1}":"&Rho;","\u{03A3}":"&Sigma;","\u{03A4}":"&Tau;","\u{03A5}":"&Upsilon;","\u{03A6}":"&Phi;","\u{03A7}":"&Chi;","\u{03A8}":"&Psi;","\u{03A9}":"&Omega;","\u{03B1}":"&alpha;","\u{03B2}":"&beta;","\u{03B3}":"&gamma;","\u{03B4}":"&delta;","\u{03B5}":"&epsilon;","\u{03B6}":"&zeta;","\u{03B7}":"&eta;","\u{03B8}":"&theta;","\u{03B9}":"&iota;","\u{03BA}":"&kappa;","\u{03BB}":"&lambda;","\u{03BC}":"&mu;","\u{03BD}":"&nu;","\u{03BE}":"&xi;","\u{03BF}":"&omicron;","\u{03C0}":"&pi;","\u{03C1}":"&rho;","\u{03C2}":"&sigmaf;","\u{03C3}":"&sigma;","\u{03C4}":"&tau;","\u{03C5}":"&upsilon;","\u{03C6}":"&phi;","\u{03C7}":"&chi;","\u{03C8}":"&psi;","\u{03C9}":"&omega;","\u{03D1}":"&thetasym;","\u{03D2}":"&upsih;","\u{03D6}":"&piv;","\u{2022}":"&bull;","\u{2026}":"&hellip;","\u{2032}":"&prime;","\u{2033}":"&Prime;","\u{203E}":"&oline;","\u{2044}":"&frasl;","\u{2118}":"&weierp;","\u{2111}":"&image;","\u{211C}":"&real;","\u{2122}":"&trade;","\u{2135}":"&alefsym;","\u{2190}":"&larr;","\u{2191}":"&uarr;","\u{2192}":"&rarr;","\u{2193}":"&darr;","\u{2194}":"&harr;","\u{21B5}":"&crarr;","\u{21D0}":"&lArr;","\u{21D1}":"&uArr;","\u{21D2}":"&rArr;","\u{21D3}":"&dArr;","\u{21D4}":"&hArr;","\u{2200}":"&forall;","\u{2202}":"&part;","\u{2203}":"&exist;","\u{2205}":"&empty;","\u{2207}":"&nabla;","\u{2208}":"&isin;","\u{2209}":"&notin;","\u{220B}":"&ni;","\u{220F}":"&prod;","\u{2211}":"&sum;","\u{2212}":"&minus;","\u{2217}":"&lowast;","\u{221A}":"&radic;","\u{221D}":"&prop;","\u{221E}":"&infin;","\u{2220}":"&ang;","\u{2227}":"&and;","\u{2228}":"&or;","\u{2229}":"&cap;","\u{222A}":"&cup;","\u{222B}":"&int;","\u{2234}":"&there4;","\u{223C}":"&sim;","\u{2245}":"&cong;","\u{2248}":"&asymp;","\u{2260}":"&ne;","\u{2261}":"&equiv;","\u{2264}":"&le;","\u{2265}":"&ge;","\u{2282}":"&sub;","\u{2283}":"&sup;","\u{2284}":"&nsub;","\u{2286}":"&sube;","\u{2287}":"&supe;","\u{2295}":"&oplus;","\u{2297}":"&otimes;","\u{22A5}":"&perp;","\u{22C5}":"&sdot;","\u{2308}":"&lceil;","\u{2309}":"&rceil;","\u{230A}":"&lfloor;","\u{230B}":"&rfloor;","\u{2329}":"&lang;","\u{232A}":"&rang;","\u{25CA}":"&loz;","\u{2660}":"&spades;","\u{2663}":"&clubs;","\u{2665}":"&hearts;","\u{2666}":"&diams;",

    // Markup-significant and internationalization characters
    // https://www.w3.org/TR/html4/sgml/entities.html#h-24.4.1
    "\u{0022}":"&quot;","\u{0026}":"&amp;","\u{003C}":"&lt;","\u{003E}":"&gt;","\u{0152}":"&OElig;","\u{0153}":"&oelig;","\u{0160}":"&Scaron;","\u{0161}":"&scaron;","\u{0178}":"&Yuml;","\u{02C6}":"&circ;","\u{02DC}":"&tilde;","\u{2002}":"&ensp;","\u{2003}":"&emsp;","\u{2009}":"&thinsp;","\u{200C}":"&zwnj;","\u{200D}":"&zwj;","\u{200E}":"&lrm;","\u{200F}":"&rlm;","\u{2013}":"&ndash;","\u{2014}":"&mdash;","\u{2018}":"&lsquo;","\u{2019}":"&rsquo;","\u{201A}":"&sbquo;","\u{201C}":"&ldquo;","\u{201D}":"&rdquo;","\u{201E}":"&bdquo;","\u{2020}":"&dagger;","\u{2021}":"&Dagger;","\u{2030}":"&permil;","\u{2039}":"&lsaquo;","\u{203A}":"&rsaquo;","\u{20AC}":"&euro;"
]

private let html4decode: [String: Character] = [
    // ISO 8859-1 characters
    // https://www.w3.org/TR/html4/sgml/entities.html#iso-88591
    "&nbsp;":"\u{00A0}","&iexcl;":"\u{00A1}","&cent;":"\u{00A2}","&pound;":"\u{00A3}","&curren;":"\u{00A4}","&yen;":"\u{00A5}","&brvbar;":"\u{00A6}","&sect;":"\u{00A7}","&uml;":"\u{00A8}","&copy;":"\u{00A9}","&ordf;":"\u{00AA}","&laquo;":"\u{00AB}","&not;":"\u{00AC}","&shy;":"\u{00AD}","&reg;":"\u{00AE}","&macr;":"\u{00AF}","&deg;":"\u{00B0}","&plusmn;":"\u{00B1}","&sup2;":"\u{00B2}","&sup3;":"\u{00B3}","&acute;":"\u{00B4}","&micro;":"\u{00B5}","&para;":"\u{00B6}","&middot;":"\u{00B7}","&cedil;":"\u{00B8}","&sup1;":"\u{00B9}","&ordm;":"\u{00BA}","&raquo;":"\u{00BB}","&frac14;":"\u{00BC}","&frac12;":"\u{00BD}","&frac34;":"\u{00BE}","&iquest;":"\u{00BF}","&Agrave;":"\u{00C0}","&Aacute;":"\u{00C1}","&Acirc;":"\u{00C2}","&Atilde;":"\u{00C3}","&Auml;":"\u{00C4}","&Aring;":"\u{00C5}","&AElig;":"\u{00C6}","&Ccedil;":"\u{00C7}","&Egrave;":"\u{00C8}","&Eacute;":"\u{00C9}","&Ecirc;":"\u{00CA}","&Euml;":"\u{00CB}","&Igrave;":"\u{00CC}","&Iacute;":"\u{00CD}","&Icirc;":"\u{00CE}","&Iuml;":"\u{00CF}","&ETH;":"\u{00D0}","&Ntilde;":"\u{00D1}","&Ograve;":"\u{00D2}","&Oacute;":"\u{00D3}","&Ocirc;":"\u{00D4}","&Otilde;":"\u{00D5}","&Ouml;":"\u{00D6}","&times;":"\u{00D7}","&Oslash;":"\u{00D8}","&Ugrave;":"\u{00D9}","&Uacute;":"\u{00DA}","&Ucirc;":"\u{00DB}","&Uuml;":"\u{00DC}","&Yacute;":"\u{00DD}","&THORN;":"\u{00DE}","&szlig;":"\u{00DF}","&agrave;":"\u{00E0}","&aacute;":"\u{00E1}","&acirc;":"\u{00E2}","&atilde;":"\u{00E3}","&auml;":"\u{00E4}","&aring;":"\u{00E5}","&aelig;":"\u{00E6}","&ccedil;":"\u{00E7}","&egrave;":"\u{00E8}","&eacute;":"\u{00E9}","&ecirc;":"\u{00EA}","&euml;":"\u{00EB}","&igrave;":"\u{00EC}","&iacute;":"\u{00ED}","&icirc;":"\u{00EE}","&iuml;":"\u{00EF}","&eth;":"\u{00F0}","&ntilde;":"\u{00F1}","&ograve;":"\u{00F2}","&oacute;":"\u{00F3}","&ocirc;":"\u{00F4}","&otilde;":"\u{00F5}","&ouml;":"\u{00F6}","&divide;":"\u{00F7}","&oslash;":"\u{00F8}","&ugrave;":"\u{00F9}","&uacute;":"\u{00FA}","&ucirc;":"\u{00FB}","&uuml;":"\u{00FC}","&yacute;":"\u{00FD}","&thorn;":"\u{00FE}","&yuml;":"\u{00FF}",

    // Symbols, mathematical symbols, and Greek letters
    // https://www.w3.org/TR/html4/sgml/entities.html#h-24.3.1
    "&fnof;":"\u{0192}","&Alpha;":"\u{0391}","&Beta;":"\u{0392}","&Gamma;":"\u{0393}","&Delta;":"\u{0394}","&Epsilon;":"\u{0395}","&Zeta;":"\u{0396}","&Eta;":"\u{0397}","&Theta;":"\u{0398}","&Iota;":"\u{0399}","&Kappa;":"\u{039A}","&Lambda;":"\u{039B}","&Mu;":"\u{039C}","&Nu;":"\u{039D}","&Xi;":"\u{039E}","&Omicron;":"\u{039F}","&Pi;":"\u{03A0}","&Rho;":"\u{03A1}","&Sigma;":"\u{03A3}","&Tau;":"\u{03A4}","&Upsilon;":"\u{03A5}","&Phi;":"\u{03A6}","&Chi;":"\u{03A7}","&Psi;":"\u{03A8}","&Omega;":"\u{03A9}","&alpha;":"\u{03B1}","&beta;":"\u{03B2}","&gamma;":"\u{03B3}","&delta;":"\u{03B4}","&epsilon;":"\u{03B5}","&zeta;":"\u{03B6}","&eta;":"\u{03B7}","&theta;":"\u{03B8}","&iota;":"\u{03B9}","&kappa;":"\u{03BA}","&lambda;":"\u{03BB}","&mu;":"\u{03BC}","&nu;":"\u{03BD}","&xi;":"\u{03BE}","&omicron;":"\u{03BF}","&pi;":"\u{03C0}","&rho;":"\u{03C1}","&sigmaf;":"\u{03C2}","&sigma;":"\u{03C3}","&tau;":"\u{03C4}","&upsilon;":"\u{03C5}","&phi;":"\u{03C6}","&chi;":"\u{03C7}","&psi;":"\u{03C8}","&omega;":"\u{03C9}","&thetasym;":"\u{03D1}","&upsih;":"\u{03D2}","&piv;":"\u{03D6}","&bull;":"\u{2022}","&hellip;":"\u{2026}","&prime;":"\u{2032}","&Prime;":"\u{2033}","&oline;":"\u{203E}","&frasl;":"\u{2044}","&weierp;":"\u{2118}","&image;":"\u{2111}","&real;":"\u{211C}","&trade;":"\u{2122}","&alefsym;":"\u{2135}","&larr;":"\u{2190}","&uarr;":"\u{2191}","&rarr;":"\u{2192}","&darr;":"\u{2193}","&harr;":"\u{2194}","&crarr;":"\u{21B5}","&lArr;":"\u{21D0}","&uArr;":"\u{21D1}","&rArr;":"\u{21D2}","&dArr;":"\u{21D3}","&hArr;":"\u{21D4}","&forall;":"\u{2200}","&part;":"\u{2202}","&exist;":"\u{2203}","&empty;":"\u{2205}","&nabla;":"\u{2207}","&isin;":"\u{2208}","&notin;":"\u{2209}","&ni;":"\u{220B}","&prod;":"\u{220F}","&sum;":"\u{2211}","&minus;":"\u{2212}","&lowast;":"\u{2217}","&radic;":"\u{221A}","&prop;":"\u{221D}","&infin;":"\u{221E}","&ang;":"\u{2220}","&and;":"\u{2227}","&or;":"\u{2228}","&cap;":"\u{2229}","&cup;":"\u{222A}","&int;":"\u{222B}","&there4;":"\u{2234}","&sim;":"\u{223C}","&cong;":"\u{2245}","&asymp;":"\u{2248}","&ne;":"\u{2260}","&equiv;":"\u{2261}","&le;":"\u{2264}","&ge;":"\u{2265}","&sub;":"\u{2282}","&sup;":"\u{2283}","&nsub;":"\u{2284}","&sube;":"\u{2286}","&supe;":"\u{2287}","&oplus;":"\u{2295}","&otimes;":"\u{2297}","&perp;":"\u{22A5}","&sdot;":"\u{22C5}","&lceil;":"\u{2308}","&rceil;":"\u{2309}","&lfloor;":"\u{230A}","&rfloor;":"\u{230B}","&lang;":"\u{2329}","&rang;":"\u{232A}","&loz;":"\u{25CA}","&spades;":"\u{2660}","&clubs;":"\u{2663}","&hearts;":"\u{2665}","&diams;":"\u{2666}",

    // Markup-significant and internationalization characters
    // https://www.w3.org/TR/html4/sgml/entities.html#h-24.4.1
    "&quot;":"\u{0022}","&amp;":"\u{0026}","&lt;":"\u{003C}","&gt;":"\u{003E}","&OElig;":"\u{0152}","&oelig;":"\u{0153}","&Scaron;":"\u{0160}","&scaron;":"\u{0161}","&Yuml;":"\u{0178}","&circ;":"\u{02C6}","&tilde;":"\u{02DC}","&ensp;":"\u{2002}","&emsp;":"\u{2003}","&thinsp;":"\u{2009}","&zwnj;":"\u{200C}","&zwj;":"\u{200D}","&lrm;":"\u{200E}","&rlm;":"\u{200F}","&ndash;":"\u{2013}","&mdash;":"\u{2014}","&lsquo;":"\u{2018}","&rsquo;":"\u{2019}","&sbquo;":"\u{201A}","&ldquo;":"\u{201C}","&rdquo;":"\u{201D}","&bdquo;":"\u{201E}","&dagger;":"\u{2020}","&Dagger;":"\u{2021}","&permil;":"\u{2030}","&lsaquo;":"\u{2039}","&rsaquo;":"\u{203A}","&euro;":"\u{20AC}"
]

private let amp: Character = "&"
private let semicolon: Character = ";"

public extension String {
    /// Return string as HTML encoded
    public func asHTMLEntities() -> String {
        var str = ""

        for char in self.characters {
            if let entity = html4encode[char] {
                str.append(entity)
            }
            else {
                str.append(char)
            }
        }

        return str
    }

    /// Return string as HTML decoded
    public func fromHTMLEntities() -> String {
        var str = ""
        var entityBuffer = ""
        var insideEntityToken = false

        for char in self.characters {
            if char == amp {
                // reached entity prefix character, &
                // no nesting of & inside entity, so flush current buffer contents
                str.append(entityBuffer)

                // reset buffer
                entityBuffer = ""
                entityBuffer.append(char)

                // set flag
                insideEntityToken = true
            }
            else if insideEntityToken {
                // currently parsing a possible entity
                // add char to buffer
                entityBuffer.append(char)

                if char == semicolon {
                    // reached entity suffix character, ;
                    // look up unicode from dictionary
                    if let unicode = html4decode[entityBuffer] {
                        // entity is valid; append unicode to decoded str
                        str.append(unicode)
                    }
                    else {
                        // entity is not valid; flush buffer
                        str.append(entityBuffer)
                    }

                    // reset entity parse state
                    entityBuffer = ""
                    insideEntityToken = false
                }
            }
            else {
                // not parsing a possible entity
                // pass char straight through to decoded str
                str.append(char)
            }
        }

        // flush buffer since its content is no longer a valid entity
        str.append(entityBuffer)

        return str
    }
}
