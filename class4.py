# --1
queryset = Film.objects.filter(rating='PG-13').values_list('title','special_features').all()
# --2
queryset = Film.objects.distinct().values_list('length')
# --3
queryset = Film.objects.filter(replacement_cost__range = (20,24)).values_list('title','rental_rate','replacement_cost')
# --4
queryset = Film.objects.filter(special_features__contains = 'Behind the Scenes').values_list('title','category__name','rating')
# --5
queryset = Film.objects.filter(title = 'ZOOLANDER FICTION').values_list('title','actor__first_name','actor__last_name')
# --6
# You could archieve the same result with a get statement tho.
queryset = Store.objects.filter(store_id = 1).values_list('address__address','address__city__city','address__city__country__country')
# --7
q1 = Film.objects.all().values('film_id','title','rating')
q2 = Film.objects.all().values('film_id','title','rating')
result = []
for left in q1:
    for right in q2:
        if (left['film_id'] != right['film_id']) and (left['rating'] == right['rating']):
            result.append((left['title'], left['rating'], right['title'], right['rating']))
# --8
queryset = Inventory.objects.filter(store__store_id = 2).values_list('film__title',).distinct()