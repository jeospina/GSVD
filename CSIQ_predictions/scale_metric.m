function data=scale_metric(Q)
    Q_max=max(Q);
    Q_min=min(Q);
    Q_m=100./(Q_max-Q_min);
    Q_b=-Q_m.*Q_min;
    data=Q.*Q_m+Q_b;
