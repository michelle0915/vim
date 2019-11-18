(ql:quickload "usocket")

(defun eval-print-error (readstring)
  (handler-case (eval readstring)
    (error (c) (format nil "ERROR: ~A" c))))

(defun repl (port)
  (usocket:with-socket-listener (socket "127.0.0.1" port :reuseaddress t)
    (handler-case 
      (loop with terminate = nil
            until terminate
          do
          ;(usocket:wait-for-input socket)
          (usocket:with-connected-socket (connection (usocket:socket-accept socket))
                                         (let* ((stream (usocket:socket-stream connection))
                                                (*standard-output* stream)
                                                (result (eval-print-error (read stream))))
                                           (cond ((eq result :term) (setq terminate t)
                                                                    (print "terminated" stream))
                                                 (t (print result stream)))
                                           (force-output stream))))
      (error (c) (format t "REPL server terminated by Error: ~A~%" c)))))

(repl 9000)
