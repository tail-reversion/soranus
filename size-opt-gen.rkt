#lang racket/base


(define point-sizes
  '(9 10 11 12 14 16 18))


(define baseline-factors+symbols
  '((1.2  . "")
    (1.25 . "+")
    (1.3  . "++")
    (1.35 . "+++")
    (1.4  . "++++")
    (1.45 . "+++++")))


(define size-names+scales
  '((miniscule    . 0.5)
    (tiny         . 0.6)
    (scriptsize   . 0.7)
    (footnotesize . 0.8)
    (small        . 0.9)
    (normalsize   . 1)
    (large        . 1.2)
    (Large        . 1.4)
    (LARGE        . 1.6)
    (huge         . 2.4)
    (Huge         . 2.8)
    (HUGE         . 3.2)))


(define header
  #<<STRING
% soranus~a.clo
% Copyright (C) 2018 Kelly Smith.
%
% This work may be distributed and/or modified under the
% conditions of the LaTeX Project Public License (LPPL),
% either version 1.3c of this license or (at your option)
% any later version. The latest version of this license
% is in the file:
%
%   http://www.latex-project.org/lppl.txt
%
% This work has the LPPL maintenance status `maintained'.
% 
% The Current Maintainer of this work is Kelly Smith.
%
% This work consists of the files listed in the README.

\ProvidesExplFile{soranus~a.clo}{2018/10/11}{0.1.0}{Soranus class ~a size option.}


STRING
  )


(define instance
  #<<STRING
\EditInstance {fontsize} {~a}
  {
    point-size          = ~apt,
    baseline-separation = ~apt
  }


STRING
  )


(define others
  #<<STRING
\dim_gset:Nn \g__soranus_top_skip {~apt}
\dim_gset:Nn \g__soranus_max_depth_skip {~apt}

STRING
  )


(define (round-to-quarter x)
  (/ (round (* x 4)) 4))


(define (generate-point-size-files)
  (for ([size (in-list point-sizes)])
    (for ([factor+symbol (in-list baseline-factors+symbols)])
      (write-point-size-file size (car factor+symbol) (cdr factor+symbol)))))


(define (write-point-size-file point-size baseline-factor baseline-symbol)
  (let ([title (format "~apt~a" point-size baseline-symbol)])
    (with-output-to-file #:exists 'replace
      (string-append "soranus" title ".clo")
      (λ ()
        (display (string-append (format-header title)
                                (format-all-instances point-size
                                                      baseline-factor)
                                (format-others point-size)))))))


(define (format-header title)
  (format header title title title))


(define (format-all-instances point-size baseline-factor)
  (apply string-append
         (for/list ([size-name+scale (in-list size-names+scales)])
           (let* ([size (round-to-quarter (* point-size (cdr size-name+scale)))]
                  [baselineskip (round-to-quarter (* size baseline-factor))])
             (format-instance (car size-name+scale) size baselineskip)))))


(define (format-instance name size baselineskip)
  (format instance name size baselineskip))


(define (format-others topskip)
  (format others topskip (round-to-quarter (* 0.5 topskip))))
