from django.shortcuts import render
from django.http import HttpResponse
from store.models import Product
from store.models import OrderItem

# Create your views here.

my_information = {
    'İsim' : 'Ali'
}

def say_hello(request):
    query_set = Product.objects.filter(
        id__in=OrderItem.objects.values('product_id').distinct()
    ).order_by('title')
        
    return render(request, 'hello.html' , {'name' : 'Ali', 'products':list(query_set)})
