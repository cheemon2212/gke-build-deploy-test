FROM alpine:3.6

# nginx�̃C���X�g�[��
RUN apk update && \
    apk add --no-cache nginx

# �h�L�������g���[�g
ADD app /app
ADD default.conf /etc/nginx/conf.d/default.conf

# �|�[�g�ݒ�
EXPOSE 80

RUN mkdir -p /run/nginx

# �t�H�A�O���E���h��nginx���s
CMD nginx -g "daemon off;"
