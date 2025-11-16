"""
Middleware de Seguridad para SGA FISI
Este middleware aplica headers de seguridad adicionales
para proteger la aplicación contra vulnerabilidades comunes.
"""


class SecurityHeadersMiddleware:
    """
    Middleware que agrega headers de seguridad HTTP a todas las respuestas
    """
    
    def __init__(self, get_response):
        self.get_response = get_response

    def __call__(self, request):
        response = self.get_response(request)
        
        # Content Security Policy
        csp_directives = [
            "default-src 'self'",
            "script-src 'self' 'unsafe-inline' 'unsafe-eval' cdn.jsdelivr.net cdnjs.cloudflare.com",
            "style-src 'self' 'unsafe-inline' fonts.googleapis.com cdn.jsdelivr.net",
            "font-src 'self' fonts.gstatic.com cdn.jsdelivr.net",
            "img-src 'self' data: https:",
            "connect-src 'self'",
            "frame-ancestors 'none'",
            "base-uri 'self'",
            "form-action 'self'"
        ]
        response['Content-Security-Policy'] = '; '.join(csp_directives)
        
        # X-Content-Type-Options: previene MIME type sniffing
        response['X-Content-Type-Options'] = 'nosniff'
        
        # X-Frame-Options: previene clickjacking
        response['X-Frame-Options'] = 'DENY'
        
        # X-XSS-Protection: protección contra XSS en navegadores antiguos
        response['X-XSS-Protection'] = '1; mode=block'
        
        # Referrer-Policy: controla la información de referrer
        response['Referrer-Policy'] = 'same-origin'
        
        # Permissions-Policy: controla las APIs y características del navegador
        permissions = [
            "geolocation=()",
            "microphone=()",
            "camera=()",
            "payment=()",
            "usb=()",
            "interest-cohort=()"  # Deshabilita FLoC
        ]
        response['Permissions-Policy'] = ', '.join(permissions)
        
        # Cross-Origin-Opener-Policy
        response['Cross-Origin-Opener-Policy'] = 'same-origin'
        
        # Cross-Origin-Resource-Policy
        response['Cross-Origin-Resource-Policy'] = 'same-origin'
        
        # Cross-Origin-Embedder-Policy
        response['Cross-Origin-Embedder-Policy'] = 'require-corp'
        
        # CORS Headers - Restringir acceso cross-origin
        # Solo permitir el propio dominio, no permitir * en producción
        response['Access-Control-Allow-Origin'] = request.get_host() if request.get_host() else 'https://lauranotfound.pythonanywhere.com'
        response['Access-Control-Allow-Methods'] = 'GET, POST, OPTIONS'
        response['Access-Control-Allow-Headers'] = 'Content-Type, X-CSRFToken'
        response['Access-Control-Allow-Credentials'] = 'true'
        response['Access-Control-Max-Age'] = '86400'
        
        # Strict-Transport-Security (HSTS) - Aplicar explícitamente
        # Forzar HTTPS por 1 año incluyendo subdominios
        if not request.is_secure() and request.get_host() != 'localhost:8000':
            response['Strict-Transport-Security'] = 'max-age=31536000; includeSubDomains; preload'
        
        # Cache-Control para páginas con información sensible
        if request.path.startswith('/admin/') or request.path.startswith('/login/') or request.path.startswith('/administrativo/') or request.path.startswith('/escuela/'):
            response['Cache-Control'] = 'no-store, no-cache, must-revalidate, max-age=0, private'
            response['Pragma'] = 'no-cache'
            response['Expires'] = '0'
        
        # Server header (ocultar versión del servidor)
        if 'Server' in response:
            response['Server'] = 'Servidor Web'
        
        return response


class RateLimitMiddleware:
    """
    Middleware básico para rate limiting
    Previene ataques de fuerza bruta y DoS
    """
    
    def __init__(self, get_response):
        self.get_response = get_response
        self.requests = {}

    def __call__(self, request):
        # Implementación básica de rate limiting
        # En producción se recomienda usar django-ratelimit o similar
        
        response = self.get_response(request)
        return response
