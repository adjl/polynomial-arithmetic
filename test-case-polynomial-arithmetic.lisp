(load "polynomial-arithmetic.lisp")

(test-case 'test-case-polynomial-arithmetic
           '((test test-make-term-with-constant
                   ((assert-equal '(term 1 ())  (make-term 1 (make-var-list)))
                    (assert-equal '(term -2 ()) (make-term -2 (make-var-list)))))

             (test test-make-term-with-single-variable
                   ((assert-equal '(term 1 ((x . 1)))
                                  (make-term 1 (make-var-list (make-var 'x 1))))
                    (assert-equal '(term 2 ((x . 1)))
                                  (make-term 2 (make-var-list (make-var 'x 1))))
                    (assert-equal '(term 1 ((x . 2)))
                                  (make-term 1 (make-var-list (make-var 'x 2))))
                    (assert-equal '(term 2 ((x . 2)))
                                  (make-term 2 (make-var-list (make-var 'x 2))))))

             (test test-make-term-with-multiple-variables
                   ((assert-equal '(term 1 ((x . 1) (y . 1)))
                                  (make-term 1 (make-var-list (make-var 'x 1)
                                                              (make-var 'y 1))))
                    (assert-equal '(term 2 ((x . 1) (y . 1)))
                                  (make-term 2 (make-var-list (make-var 'x 1)
                                                              (make-var 'y 1))))
                    (assert-equal '(term 1 ((x . 2) (y . 1)))
                                  (make-term 1 (make-var-list (make-var 'x 2)
                                                              (make-var 'y 1))))
                    (assert-equal '(term 1 ((x . 2) (y . 2)))
                                  (make-term 1 (make-var-list (make-var 'x 2)
                                                              (make-var 'y 2))))
                    (assert-equal '(term 2 ((x . 2) (y . 2)))
                                  (make-term 2 (make-var-list (make-var 'x 2)
                                                              (make-var 'y 2))))))

             (test test-coeff-with-constant
                   ((assert-equal 1                  (coeff (make-term 1 (make-var-list))))
                    (assert-equal -2                 (coeff (make-term -2 (make-var-list))))))

             (test test-coeff-with-single-variable
                   ((assert-equal 1                  (coeff (make-term 1 (make-var-list (make-var 'x 1)))))
                    (assert-equal 2                  (coeff (make-term 2 (make-var-list (make-var 'x 2)))))))

             (test test-coeff-with-multiple-variables
                   ((assert-equal 1                  (coeff (make-term 1 (make-var-list (make-var 'x 1)
                                                                                        (make-var 'y 1)))))
                    (assert-equal 2                  (coeff (make-term 2 (make-var-list (make-var 'x 2)
                                                                                        (make-var 'y 1)))))
                    (assert-equal 3                  (coeff (make-term 3 (make-var-list (make-var 'x 2)
                                                                                        (make-var 'y 2)))))))

             (test test-vars-with-constant
                   ((assert-equal '()                (vars (make-term 1 (make-var-list))))
                    (assert-equal '()                (vars (make-term -2 (make-var-list))))))

             (test test-vars-with-single-variable
                   ((assert-equal '((x . 1))         (vars (make-term 1 (make-var-list (make-var 'x 1)))))
                    (assert-equal '((x . 2))         (vars (make-term 2 (make-var-list (make-var 'x 2)))))))

             (test test-vars-with-multiple-variables
                   ((assert-equal '((x . 1) (y . 1)) (vars (make-term 1 (make-var-list (make-var 'x 1)
                                                                                       (make-var 'y 1)))))
                    (assert-equal '((x . 2) (y . 1)) (vars (make-term 2 (make-var-list (make-var 'x 2)
                                                                                       (make-var 'y 1)))))
                    (assert-equal '((x . 2) (y . 2)) (vars (make-term 3 (make-var-list (make-var 'x 2)
                                                                                       (make-var 'y 2)))))))

             (test test-make-poly-of-single-term
                   ((assert-equal '(poly ((term 1 ())))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list)))))
                    (assert-equal '(poly ((term 1 ((x . 2)))))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2))))))
                    (assert-equal '(poly ((term 1 ((x . 2) (y . 2)))))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2)
                                                                           (make-var 'y 2))))))))

             (test test-make-poly-of-multiple-terms
                   ((assert-equal '(poly ((term 1 ((x . 2)))
                                          (term 1 ())))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2)))
                                               (make-term 1 (make-var-list)))))
                    (assert-equal '(poly ((term 1 ((x . 2)))
                                          (term 1 ((y . 2)))))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2)))
                                               (make-term 1 (make-var-list (make-var 'y 2))))))
                    (assert-equal '(poly ((term 1 ((x . 2) (y . 2)))
                                          (term 1 ())))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2)
                                                                           (make-var 'y 2)))
                                               (make-term 1 (make-var-list)))))
                    (assert-equal '(poly ((term 1 ((x . 2) (y . 2)))
                                          (term 1 ((x . 2)))))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2)
                                                                           (make-var 'y 2)))
                                               (make-term 1 (make-var-list (make-var 'x 2))))))
                    (assert-equal '(poly ((term 1 ((x . 2) (y . 2)))
                                          (term 1 ((x . 2) (z . 2)))))
                                  (make-poly (make-term-list
                                               (make-term 1 (make-var-list (make-var 'x 2)
                                                                           (make-var 'y 2)))
                                               (make-term 1 (make-var-list (make-var 'x 2)
                                                                           (make-var 'z 2))))))))

             (test test-term+-with-constant-and-constant
                   ((assert-equal '(term 2 ())
                                  (term+ (make-term 1 (make-var-list))
                                         (make-term 1 (make-var-list))))
                    (assert-equal '(term -1 ())
                                  (term+ (make-term 1 (make-var-list))
                                         (make-term -2 (make-var-list))))
                    (assert-equal '(term -1 ())
                                  (term+ (make-term -2 (make-var-list))
                                         (make-term 1 (make-var-list))))
                    (assert-equal '(term -4 ())
                                  (term+ (make-term -2 (make-var-list))
                                         (make-term -2 (make-var-list))))))

             (test test-term+-with-single-variable-and-single-variable-of-same-order
                   ((assert-equal '(term 2 ((x . 1)))
                                  (term+ (make-term 1 (make-var-list (make-var 'x 1)))
                                         (make-term 1 (make-var-list (make-var 'x 1)))))
                    (assert-equal '(term 3 ((x . 2)))
                                  (term+ (make-term 2 (make-var-list (make-var 'x 2)))
                                         (make-term 1 (make-var-list (make-var 'x 2)))))))

             (test test-term+-with-multiple-variables-and-multiple-variables-of-same-order
                   ((assert-equal '(term 2 ((x . 1) (y . 1)))
                                  (term+ (make-term 1 (make-var-list (make-var 'x 1)
                                                                     (make-var 'y 1)))
                                         (make-term 1 (make-var-list (make-var 'x 1)
                                                                     (make-var 'y 1)))))
                    (assert-equal '(term 3 ((x . 2) (y . 1)))
                                  (term+ (make-term 2 (make-var-list (make-var 'x 2)
                                                                     (make-var 'y 1)))
                                         (make-term 1 (make-var-list (make-var 'x 2)
                                                                     (make-var 'y 1)))))
                    (assert-equal '(term 4 ((x . 2) (y . 2)))
                                  (term+ (make-term 2 (make-var-list (make-var 'x 2)
                                                                     (make-var 'y 2)))
                                         (make-term 2 (make-var-list (make-var 'x 2)
                                                                     (make-var 'y 2)))))))))
